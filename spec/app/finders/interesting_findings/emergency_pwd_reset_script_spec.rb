# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::EmergencyPwdResetScript do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'emergency_pwd_reset_script') }

  describe '#aggressive' do
    xit
  end
end
