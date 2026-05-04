# frozen_string_literal: true

describe WPScan do
  it 'has a version number' do
    expect(WPScan::VERSION).not_to be nil
  end

  describe '#app_name' do
    it 'returns the overriden string' do
      expect(WPScan.app_name).to eql 'wpscan'
    end
  end

  describe '#user_cache_dir' do
    context 'when XDG_CACHE_HOME is not set' do
      before do
        stub_const('ENV', ENV.to_hash.tap { |e| e.delete('XDG_CACHE_HOME') })
        allow(Dir).to receive(:home).and_return('/home/user')
      end

      it 'returns the default XDG cache path' do
        expect(WPScan.user_cache_dir.to_s).to eql '/home/user/.cache/wpscan'
      end
    end

    context 'when XDG_CACHE_HOME is set' do
      before { stub_const('ENV', ENV.to_hash.merge('XDG_CACHE_HOME' => '/home/user/cache')) }

      it 'returns the XDG cache path' do
        expect(WPScan.user_cache_dir.to_s).to eql '/home/user/cache/wpscan'
      end
    end
  end
end
