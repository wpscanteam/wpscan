# frozen_string_literal: true

describe WPScan::Model::User do
  subject(:user) { described_class.new(username, opts) }
  let(:username) { 'john' }
  let(:opts)     { {} }

  describe '#new' do
    its(:username) { should eql username }

    context 'when opts' do
      let(:opts) { super().merge(id: 12, password: 'passwd') }

      its(:id)       { should eql 12 }
      its(:password) { should eql 'passwd' }
    end
  end

  describe '#==' do
    context 'when another object' do
      it 'returns false' do
        expect(user == username).to be false
      end
    end

    context 'when the same username' do
      it 'return true' do
        expect(user == user.dup).to be true
      end
    end

    context 'when not the same username' do
      it 'returns false' do
        expect(user == described_class.new('test')).to be false
      end
    end
  end

  describe '#to_s' do
    its(:to_s) { should eql username }
  end
end
