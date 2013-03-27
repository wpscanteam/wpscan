# encoding: UTF-8

require 'spec_helper'

describe WpUser do
  it_behaves_like 'WpUser::Existable'

  subject(:wp_user) { WpUser.new(uri, options) }
  let(:uri)         { URI.parse('http://example.com') }
  let(:options)     { {} }

  describe '#allowed_options' do
    [:id, :login, :display_name, :password].each do |sym|
      its(:allowed_options) { should include sym }
    end

    its(:allowed_options) { should_not include :name }
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

        wp_user.uri.should == uri.merge('?author=2')
      end
    end
  end

  describe '#<=>' do
    it 'bases the comparaison on the :id' do
      wp_user.id = 1
      other      = WpUser.new(uri, id: 3)

      wp_user.<=>(other).should === 1.<=>(3)
    end
  end

  describe '#===, #==' do
    context 'when the :id and :login are the same' do
      it 'is ===, and ==' do
        WpUser.new(uri, id: 1, name: 'yo').should == WpUser.new(uri, id: 1, name: 'yo')
      end
    end

    context 'when :id and :login are different' do
      it 'is not === or ==' do
        WpUser.new(uri, id: 1, name: 'yo').should_not == WpUser.new(uri, id: 2, name:'yo')
      end
    end
  end

end
