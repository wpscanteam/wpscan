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
      expect(@cache.storage_path).to match(/#{cache_dir}/)
    end
  end

  describe '#serializer' do
    it 'should return the default serializer : Marshal' do
      expect(@cache.serializer).to     eq Marshal
      expect(@cache.serializer).not_to eq YAML
    end
  end

  describe '#clean' do
    it "should remove all files from the cache dir (#{@cache_dir}" do
      # clean is executed by other tests before
      before = count_files_in_dir(@cache.cache_dir)
      test_dir = File.expand_path("#{@cache.cache_dir}/test")
      Dir.mkdir test_dir
      #change the modification date
      %x[ touch -t 200701310846.26 #{test_dir} ]
      expect(count_files_in_dir(@cache.cache_dir)).to eq (before + 1)
      @cache.clean
      expect(count_files_in_dir(@cache.cache_dir)).to eq before
    end
  end

  describe '#read_entry' do
    after { expect(@cache.read_entry(key)).to eq @expected }

    context 'when the entry does not exist' do
      let(:key) { Digest::SHA1.hexdigest('hello world') }

      it 'should return nil' do
        @expected = nil
      end
    end

    context 'when the file exist but is empty (marshal data too short error)' do
      let(:key) { 'empty-file' }

      it 'returns nil' do
        File.new(File.join(@cache.storage_path, key), File::CREAT)

        @expected = nil
      end
    end
  end

  describe '#write_entry, #read_entry' do

    after :each do
      @cache.write_entry(@key, @data, @timeout)
      expect(@cache.read_entry(@key)).to be === @expected
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

      (1..5).each do |_|
        storage_dirs << CacheFileStore.new(cache_dir).storage_path
      end

      expect(storage_dirs.uniq.size).to eq 5
    end
  end
end
