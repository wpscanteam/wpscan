# encoding: UTF-8

require 'spec_helper'

describe WpUser do
  it_behaves_like 'WpUser::Existable'
  it_behaves_like 'WpUser::BruteForcable'

  subject(:wp_user) { WpUser.new(uri, options) }
  let(:uri)         { URI.parse('http://example.com') }
  let(:options)     { {} }

  describe '#allowed_options' do
    [:id, :login, :display_name, :password].each do |sym|
      its(:allowed_options) { is_expected.to include sym }
    end

    its(:allowed_options) { is_expected.not_to include :name }
  end

  describe '#uri' do
    context 'when the id is not set' do
      it 'raises an error' do
        expect { wp_user.uri }.to raise_error('The id is nil')
      end
    end

    context 'when the id is set' do
      it 'returns the uri to the auhor page' do
        wp_user.id = 2

        expect(wp_user.uri).to eq uri.merge('?author=2')
      end
    end
  end

  describe '#to_s' do
    after do
      subject.id = 1
      expect(subject.to_s).to eq @expected
    end

    it 'returns @id' do
      @expected = '1'
    end

    context 'when @login' do
      it 'returns @id | @login' do
        subject.login = 'admin'

        @expected = '1 | admin'
      end

      context 'when @display_name' do
        it 'returns @id | @login | @display_name' do
          subject.login        = 'admin'
          subject.display_name = 'real name'

          @expected = '1 | admin | real name'
        end
      end
    end
  end

  describe '#<=>' do
    it 'bases the comparaison on the :id' do
      wp_user.id = 1
      other      = WpUser.new(uri, id: 3)

      expect(wp_user.<=>(other)).to be === 1.<=>(3)
    end
  end

  describe '#===, #==' do
    context 'when the :id and :login are the same' do
      it 'is ===, and ==' do
        expect(WpUser.new(uri, id: 1, name: 'yo')).to eq WpUser.new(uri, id: 1, name: 'yo')
      end
    end

    context 'when :id and :login are different' do
      it 'is not === or ==' do
        expect(WpUser.new(uri, id: 1, name: 'yo')).not_to eq WpUser.new(uri, id: 2, name:'yo')
      end
    end
  end

end
