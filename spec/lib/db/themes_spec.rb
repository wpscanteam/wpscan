describe WPScan::DB::Themes do
  subject(:themes) { described_class }

  describe '#all_slugs' do
    its(:all_slugs) { should eql %w[no-vulns-popular dignitas-themes yaaburnee-themes] }
  end

  describe '#popular_slugs' do
    its(:popular_slugs) { should eql %w[no-vulns-popular dignitas-themes] }
  end

  describe '#vulnerable_slugs' do
    its(:vulnerable_slugs) { should eql %w[dignitas-themes yaaburnee-themes] }
  end
end
