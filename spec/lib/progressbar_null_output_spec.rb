# frozen_string_literal: true

describe WPScan::ProgressBarNullOutput do
  subject(:output) { described_class.new }

  describe '#log, #logs' do
    context 'when no log added' do
      its(:logs) { should eql([]) }
    end

    context 'when adding log' do
      it 'contains the added logs' do
        output.log 'M1'
        expect(output.logs).to eql(%w[M1])

        output.log 'M2'
        expect(output.logs).to eql(%w[M1 M2])

        expect(output.log).to eql(%w[M1 M2])
      end

      it 'does not add duplicate' do
        output.log 'M1'
        output.log 'M1'
        output.log 'M2'

        expect(output.logs).to eql(%w[M1 M2])
        expect(output.log).to eql(%w[M1 M2])
      end
    end
  end
end
