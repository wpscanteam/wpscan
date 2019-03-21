# frozen_string_literal: true

require_relative 'enumeration/users'
require_relative 'enumeration/medias'
require_relative 'enumeration/themes'
require_relative 'enumeration/plugins'
require_relative 'enumeration/timthumbs'
require_relative 'enumeration/config_backups'
require_relative 'enumeration/db_exports'

shared_examples 'App::Views::Enumeration' do
  let(:controller) { WPScan::Controller::Enumeration.new }
  let(:tpl_vars)   { { url: target_url } }

  it_behaves_like 'App::Views::Enumeration::Users'
  it_behaves_like 'App::Views::Enumeration::Medias'
  it_behaves_like 'App::Views::Enumeration::Themes'
  it_behaves_like 'App::Views::Enumeration::Plugins'
  it_behaves_like 'App::Views::Enumeration::Timthumbs'
  it_behaves_like 'App::Views::Enumeration::ConfigBackups'
  it_behaves_like 'App::Views::Enumeration::DbExports'
end
