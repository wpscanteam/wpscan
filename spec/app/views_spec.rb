# frozen_string_literal: true

describe 'App::Views' do
  let(:target_url) { 'http://ex.lo/' }
  let(:target)     { WPScan::Target.new(target_url) }
  let(:fixtures)   { SPECS.join('output') }

  # CliNoColour is used to test the CLI output to avoid the painful colours
  # in the expected output.
  %i[JSON CliNoColour].each do |formatter|
    context "when #{formatter}" do
      it_behaves_like 'App::Views::VulnApi'
      it_behaves_like 'App::Views::WpVersion'
      it_behaves_like 'App::Views::MainTheme'
      it_behaves_like 'App::Views::Enumeration'

      let(:parsed_options) { { url: target_url, format: formatter.to_s.underscore.dasherize } }

      before do
        WPScan::ParsedCli.options = parsed_options
        # Resets the formatter to ensure the correct one is loaded
        controller.class.class_variable_set(:@@formatter, nil)
      end

      after do
        view_filename   = defined?(expected_view) ? expected_view : view
        view_filename   = "#{view_filename}.#{formatter.to_s.underscore.downcase}"
        controller_dir  = controller.class.to_s.demodulize.underscore.downcase
        expected_output = File.read(fixtures.join(controller_dir, view_filename))

        expect($stdout).to receive(:puts).with(expected_output)

        controller.output(view, @tpl_vars)
        controller.formatter.beautify # Mandatory to be able to test formatter such as JSON
      end
    end
  end
end
