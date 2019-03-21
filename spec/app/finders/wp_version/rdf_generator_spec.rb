# frozen_string_literal: true

describe WPScan::Finders::WpVersion::RDFGenerator do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('wp_version', 'rdf_generator') }

  xit
end
