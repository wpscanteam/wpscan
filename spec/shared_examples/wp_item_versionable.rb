# encoding: UTF-8

shared_examples 'WpItem::Versionable' do

  describe '#version' do
    let(:fixtures_dir) { MODELS_FIXTURES + '/wp_item/versionable' }
    let(:readme_url)   { subject.uri.merge('readme.txt').to_s }

    context 'when the version is already set' do
      it 'returns it' do
        subject.version = '1.2'
        expect(subject.version).to eq '1.2'
      end
    end

    context 'otherwise' do
      after do
        stub_request_to_fixture(url: readme_url, fixture: fixtures_dir + @file)
        expect(subject.version).to eq @expected
      end

      context 'when version is "trunk"' do
        it 'returns nil' do
          @file     = '/trunk-version.txt'
          @expected = nil
        end
      end

      context 'when the version is valid' do
        it 'returns it' do
          @file     = '/simple-login-lockdown-0.4.txt'
          @expected = '0.4'
        end
      end
    end
  end

  describe '#to_s' do
    after do
      allow(subject).to receive(:version).and_return(@version)
      subject.name = 'some-name'

      expect(subject.to_s).to eq @expected
    end

    context 'when the version does not exist' do
      it 'returns only the name' do
        @version = nil
        @expected = 'some-name'
      end
    end

    context 'when the version exists' do
      it 'returns the name and the version' do
        @version  = '1.3'
        @expected = 'some-name - v1.3'
      end
    end
  end

end
