#!/usr/bin/env ruby

require 'rubygems'
require 'uri'
require 'dm-core'
require 'dm-migrations'
require 'dm-constraints'
require 'optparse'
require 'nokogiri'
require 'typhoeus'

@db = "#{Dir.pwd}/wp-versions.db"

# return [ Array<String> ] The Stable versions (sorted by number DESC)
def get_remote_wp_versions
  versions = []
  page = Nokogiri::HTML(Typhoeus.get('http://wordpress.org/download/release-archive/').body)

  page.css('.widefat').first.css('tbody tr td:first').each do |node|
    versions << node.text.strip
  end
  versions.reverse
end

def remove_dir(dir)
  %x{rm -rf #{dir}}
end

def download(file_url, dest)
  %x{wget -q -np -O #{dest} #{file_url} > /dev/null}
end

def wp_version_zip_url(version)
  "http://wordpress.org/wordpress-#{version}.zip"
end

def wp_version_zip_md5(version)
  Typhoeus.get("#{wp_version_zip_url(version)}.md5").body
end

def file_md5(file_path)
  Digest::MD5.file(file_path).hexdigest
end

def web_page_md5(url)
  Digest::MD5.hexdigest(Typhoeus.get(url).body)
end

def download_and_unzip_version(version, dest)
  dest_zip = "/tmp/wp-#{version}.zip"

  download(wp_version_zip_url(version), dest_zip)
  
  if $?.exitstatus === 0 and File.exists?(dest_zip)
    if file_md5(dest_zip) === wp_version_zip_md5(version)
      remove_dir("#{dest}/wordpress/")
      unzip(dest_zip, dest)

      return true
    else
      raise 'Invalid md5'
      # Redownload the file ?
    end
  else
    raise 'Download error'
  end 
end

def unzip(zip_path, dest)
  %x{unzip -o -d #{dest} #{zip_path}}
end

parser = OptionParser.new("Usage: ruby #{$0} [options]", 50) do |opts|
  opts.on('--db PATH-TO-DB', '-d', 'Path to the db, default: wp-versions.db') do |db|
    @db = db
  end

  opts.on('--update', '-u', 'Update the db') do
    @update = true
  end

  opts.on('--verbose', '-v', 'Verbose Mode') do
    @verbose = true
  end

  opts.on('--show-unique-fingerprints WP-VERSION', '--suf', 'Output the unique file hashes for the given version of WordPress') do |version|
    @version = version
  end

  opts.on('--search-hash HASH', '--sh', 'Search the hash and output the WP versions & file') do |hash|
    @hash = hash
  end

  opts.on('--search-file RELATIVE-FILE-PATH', '--sf', 'Search the file and output the Wp versions & hashes') do |file|
    @file = file
  end

  opts.on('--fingerprint URL', 'Fingerprint a remote wordpress blog') do |url|
    @target_url  = url
    @target_url += '/' if @target_url[-1,1] != '/'
  end
end
parser.parse!

DataMapper::Logger.new($stdout, @verbose ? :debug : :fatal)
DataMapper::setup(:default, "sqlite://#{@db}")

class Version
  include DataMapper::Resource

  has n, :fingerprints, constraint: :destroy

  property :id, Serial
  property :number, String, required: true, unique: true
end

class Path
  include DataMapper::Resource

  has n, :fingerprints, constraint: :destroy

  property :id, Serial
  property :value, String, required: true, unique: true
end

class Fingerprint
  include DataMapper::Resource

  belongs_to :version, key: true
  belongs_to :path, key: true

  property :md5_hash, String, required: true, length: 32

  # DataMapper does not seem to support ordering by a column in a joining model
  # Solution found on StackOverflow ("DataMapper: Sorting results though association")
  def self.order_by_version(direction = :asc)
    order = DataMapper::Query::Direction.new(version.number, direction)
    query = all.query
    query.instance_variable_set('@order', [order])
    query.instance_variable_set('@links', [relationships['version'].inverse])
    all(query)
  end
end

DataMapper.auto_upgrade!

# Update
if @update
  remote_versions = get_remote_wp_versions()
  puts "#{remote_versions.size} remote versions number retrieved"

  remote_versions.each do |version|
    unless Version.first(number: version)
      db_version = Version.create(number: version)
      version_dir = "/tmp/wordpress/"

      puts "Downloading and unziping v#{version} to #{version_dir}"
      download_and_unzip_version(version, '/tmp/')

      puts 'Processing Fingerprints'
      Dir[File.join(version_dir, '**', '*')].reject { |f| f =~ /^*.php$/ || Dir.exists?(f) }.each do |filename|
        hash      = Digest::MD5.file(filename).hexdigest
        file_path = filename.gsub(version_dir, '')
        db_path   = Path.first_or_create(value: file_path)
        fingerprint = Fingerprint.create(path_id: db_path.id, md5_hash: hash)

        
        db_version.fingerprints << fingerprint
      end
      db_version.save
    else
      puts "Version #{version} already in DB, skipping"
    end
  end
end

if @version
  if version = Version.first(number: @version)
    repository(:default).adapter.select('SELECT md5_hash, path_id, version_id, paths.value AS path FROM fingerprints LEFT JOIN paths ON path_id = id GROUP BY md5_hash ORDER BY path ASC').each do |f|
      if f.version_id == version.id
        puts "#{f.md5_hash} #{f.path}" 
      end
    end
  else
    puts "The version supplied: '#{@version}' is not in the database"
  end
end

if @hash
  puts "Results for #{@hash}:"
  Fingerprint.order_by_version(:desc).all(md5_hash: @hash).each do |f|
    puts "  #{f.version.number} #{f.path.value}"
  end
end

if @file
  puts "Results for #{@file}:"

  if path = Path.first(value: @file)
    Fingerprint.order_by_version(:desc).all(path_id: path.id).each do |f|
      puts "  #{f.md5_hash} #{f.version.number}"
    end
  else
    puts 'File not found (the argument must be a relative file path. e.g: wp-admin/css/widgets.css)'
  end
end

if @target_url
  uri = URI.parse(@target_url)
  
  Version.all(order: [ :number.desc ]).each do |version|
    total_urls = version.fingerprints.count
    matches    = 0
    percent    = 0

    version.fingerprints.each do |f|
      url = uri.merge(f.path.value).to_s
      
      if web_page_md5(url) == f.md5_hash
        matches += 1
        puts "#{url} matches v#{version.number}" if @verbose
      end

      percent = ((matches / total_urls.to_f) * 100).round(2)

      print("Version #{version.number} [#{matches}/#{total_urls} #{percent}% matches]\r")
    end
    
    puts

    if percent == 100.0
      puts "The remote version is #{version.number}"
      exit
    end
  end
end

