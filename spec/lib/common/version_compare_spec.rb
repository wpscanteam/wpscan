# encoding: UTF-8

require 'spec_helper'

describe 'VersionCompare' do
  describe '::is_newer_or_same?' do
    context 'version checked is newer' do
      after { VersionCompare::is_newer_or_same?(@version1, @version2).should be_true }

      it 'should return true' do
        @version1 = '1.0'
        @version2 = '2.0'
      end

      it 'should return true' do
        @version1 = '1.0'
        @version2 = '1.1'
      end

      it 'should return true' do
        @version1 = '1.0a'
        @version2 = '1.0b'
      end

      it 'should return true' do
        @version1 = '1.0'
        @version2 = '5000000'
      end

      it 'should return true' do
        @version1 = '0'
        @version2 = '1'
      end
    end

    context 'version checked is older' do
      after { VersionCompare::is_newer_or_same?(@version1, @version2).should be_false }

      it 'should return false' do
        @version1 = '1'
        @version2 = '0'
      end

      it 'should return false' do
        @version1 = '1.0'
        @version2 = '0.5'
      end

      it 'should return false' do
        @version1 = '500000'
        @version2 = '1'
      end

      it 'should return false' do
        @version1 = '1.6.3.7.3.4'
        @version2 = '1.2.4.567.679.8.e'
      end
    end

    context 'version checked is the same' do
      after { VersionCompare::is_newer_or_same?(@version1, @version2).should be_true }

      it 'should return true' do
        @version1 = '1'
        @version2 = '1'
      end

      it 'should return true' do
        @version1 = 'a'
        @version2 = 'a'
      end

    end

    context 'version number causes Gem::Version new Exception' do
      after { VersionCompare::is_newer_or_same?(@version1, @version2).should be_false }

      it 'should return false' do
        @version1 = 'a'
        @version2 = 'b'
      end
    end

    context 'one version number is not set' do
      after { VersionCompare::is_newer_or_same?(@version1, @version2).should be_false }

      it 'should return false (version2 nil)' do
        @version1 = '1'
        @version2 = nil
      end

      it 'should return false (version1 nil)' do
        @version1 = nil
        @version2 = '1'
      end

      it 'should return false (version2 empty)' do
        @version1 = '1'
        @version2 = ''
      end

      it 'should return false (version1 empty)' do
        @version1 = ''
        @version2 = '1'
      end
    end

  end
end
