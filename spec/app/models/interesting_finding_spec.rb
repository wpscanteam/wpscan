require 'spec_helper'

describe WPScan::InterestingFinding do
  it_behaves_like WPScan::References do
    subject(:finding) { described_class.new('http://e.org/file.php', opts) }
    let(:opts)        { { references: references } }
    let(:references)  { {} }
  end
end
