require 'spec_helper'

describe WPScan::Finders::InterestingFindings::EmergencyPwdResetScript do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'interesting_findings', 'emergency_pwd_reset_script') }

  describe '#aggressive' do
    xit
  end
end
