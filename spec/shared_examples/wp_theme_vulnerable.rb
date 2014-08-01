# encoding: UTF-8

shared_examples 'WpTheme::Vulnerable' do

  describe '#vulns_file' do
    after { expect(subject.vulns_file).to eq @expected }

    context 'when :vulns_file is not set' do
      it 'returns the default one' do
        @expected = THEMES_VULNS_FILE
      end
    end

    context 'when the :vulns_file is already set' do
      it 'returns it' do
        @expected          = 'test.json'
        subject.vulns_file = @expected
      end
    end
  end

  describe '#identifier' do
    its(:identifier) { is_expected.to eq 'theme-name' }
  end

end
