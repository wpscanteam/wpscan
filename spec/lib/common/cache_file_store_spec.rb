# encoding: UTF-8

require 'spec_helper'

describe CacheFileStore do
  let(:cache_dir) { SPEC_CACHE_DIR + '/cache_file_store' }

  before :each do
    Dir.delete(cache_dir) rescue nil

    @cache = CacheFileStore.new(cache_dir)
  end

  after :each do
    @cache.clean
  end

  describe '#storage_path' do
    it 'returns the storage path given in the #new' do
      @cache.storage_path.should match(/#{cache_dir}/)
    end
  end

  describe '#serializer' do
    it 'should return the default serializer : Marshal' do
      @cache.serializer.should     == Marshal
      @cache.serializer.should_not == YAML
    end
  end

  describe '#clean' do
    it "should remove all files from the cache dir (#{@cache_dir}" do
      # let's create some files into the directory first
      (0..5).each do |i|
        File.new(@cache.storage_path + "/file_#{i}.txt", File::CREAT)
      end

      count_files_in_dir(@cache.storage_path, 'file_*.txt').should == 6
      @cache.clean
      count_files_in_dir(@cache.storage_path).should == 0
    end
  end

  describe '#read_entry (nonexistent entry)' do
    it 'should return nil' do
      @cache.read_entry(Digest::SHA1.hexdigest('hello world')).should be_nil
    end
  end

  describe '#write_entry, #read_entry' do

    after :each do
      @cache.write_entry(@key, @data, @timeout)
      @cache.read_entry(@key).should === @expected
    end

    it 'should get the correct entry (string)' do
      @timeout  = 10
      @key      = 'some_key'
      @data     = 'Hello World !'
      @expected = @data
    end

    it 'should not write the entry' do
      @timeout  = 0
      @key      = 'another_key'
      @data     = 'Another Hello World !'
      @expected = nil
    end

    ## TODO write / read for an object
  end

  describe '#storage_dir' do
    it 'should create a unique storage dir' do
      storage_dirs = []

      (1..5).each do |i|
        storage_dirs << CacheFileStore.new(cache_dir).storage_path
      end

      storage_dirs.uniq.size.should == 5
    end
  end
end
