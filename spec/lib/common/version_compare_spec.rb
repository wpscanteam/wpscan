# encoding: UTF-8

require 'spec_helper'

describe 'VersionCompare' do
  describe '::lesser_or_equal?' do
    context 'version checked is newer' do
      after { expect(VersionCompare::lesser_or_equal?(@version1, @version2)).to be_truthy }

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '2.0'
      end

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '1.1'
      end

      it 'returns true' do
        @version1 = '1.0a'
        @version2 = '1.0b'
      end

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '5000000'
      end

      it 'returns true' do
        @version1 = '0'
        @version2 = '1'
      end

      it 'returns true' do
        @version1 = '0.4.2b'
        @version2 = '2.3.3'
      end

      it 'returns true' do
        @version1 = '.47'
        @version2 = '.50.3'
      end
    end

    context 'version checked is older' do
      after { expect(VersionCompare::lesser_or_equal?(@version1, @version2)).to be_falsey }

      it 'returns false' do
        @version1 = '1'
        @version2 = '0'
      end

      it 'returns false' do
        @version1 = '1.0'
        @version2 = '0.5'
      end

      it 'returns false' do
        @version1 = '500000'
        @version2 = '1'
      end

      it 'returns false' do
        @version1 = '1.6.3.7.3.4'
        @version2 = '1.2.4.567.679.8.e'
      end

      it 'returns false' do
        @version1 = '.47'
        @version2 = '.46.3'
      end
    end

    context 'version checked is the same' do
      after { expect(VersionCompare::lesser_or_equal?(@version1, @version2)).to be_truthy }

      it 'returns true' do
        @version1 = '1'
        @version2 = '1'
      end

      it 'returns true' do
        @version1 = 'a'
        @version2 = 'a'
      end

    end

    context 'version number causes Gem::Version new Exception' do
      after { expect(VersionCompare::lesser_or_equal?(@version1, @version2)).to be_falsey }

      it 'returns false' do
        @version1 = 'a'
        @version2 = 'b'
      end
    end

    context 'one version number is not set' do
      after { expect(VersionCompare::lesser_or_equal?(@version1, @version2)).to be_falsey }

      it 'returns false (version2 nil)' do
        @version1 = '1'
        @version2 = nil
      end

      it 'returns false (version1 nil)' do
        @version1 = nil
        @version2 = '1'
      end

      it 'returns false (version2 empty)' do
        @version1 = '1'
        @version2 = ''
      end

      it 'returns false (version1 empty)' do
        @version1 = ''
        @version2 = '1'
      end
    end

  end

  describe '::lesser?' do
    context 'version checked is newer' do
      after { expect(VersionCompare::lesser?(@version1, @version2)).to be_truthy }

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '2.0'
      end

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '1.1'
      end

      it 'returns true' do
        @version1 = '1.0a'
        @version2 = '1.0b'
      end

      it 'returns true' do
        @version1 = '1.0'
        @version2 = '5000000'
      end

      it 'returns true' do
        @version1 = '0'
        @version2 = '1'
      end

      it 'returns true' do
        @version1 = '0.4.2b'
        @version2 = '2.3.3'
      end

      it 'returns true' do
        @version1 = '.47'
        @version2 = '.50.3'
      end

      it 'returns true' do
        @version1 = '2.5.9'
        @version2 = '2.5.10'
      end
    end

    context 'version checked is older' do
      after { expect(VersionCompare::lesser?(@version1, @version2)).to be_falsey }

      it 'returns false' do
        @version1 = '1'
        @version2 = '0'
      end

      it 'returns false' do
        @version1 = '1.0'
        @version2 = '0.5'
      end

      it 'returns false' do
        @version1 = '500000'
        @version2 = '1'
      end

      it 'returns false' do
        @version1 = '1.6.3.7.3.4'
        @version2 = '1.2.4.567.679.8.e'
      end

      it 'returns false' do
        @version1 = '.47'
        @version2 = '.46.3'
      end
    end

    context 'version checked is the same' do
      after { expect(VersionCompare::lesser?(@version1, @version2)).to be_falsey }

      it 'returns true' do
        @version1 = '1'
        @version2 = '1'
      end

      it 'returns true' do
        @version1 = 'a'
        @version2 = 'a'
      end

    end

    context 'version number causes Gem::Version new Exception' do
      after { expect(VersionCompare::lesser?(@version1, @version2)).to be_falsey }

      it 'returns false' do
        @version1 = 'a'
        @version2 = 'b'
      end
    end

    context 'one version number is not set' do
      after { expect(VersionCompare::lesser?(@version1, @version2)).to be_falsey }

      it 'returns false (version2 nil)' do
        @version1 = '1'
        @version2 = nil
      end

      it 'returns false (version1 nil)' do
        @version1 = nil
        @version2 = '1'
      end

      it 'returns false (version2 empty)' do
        @version1 = '1'
        @version2 = ''
      end

      it 'returns false (version1 empty)' do
        @version1 = ''
        @version2 = '1'
      end
    end
  end
end
