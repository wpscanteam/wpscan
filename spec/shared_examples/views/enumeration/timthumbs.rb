# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::Timthumbs' do
  let(:view)     { 'timthumbs' }
  let(:timthumb) { WPScan::Model::Timthumb }
  let(:version)  { WPScan::Model::Version.new('2.8.14', found_by: 'Bad Request') }

  describe 'timthumbs' do
    context 'when no timthumbs found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(timthumbs: [])
      end
    end

    context 'when timthumbs found' do
      let(:tt)        { timthumb.new("#{target_url}tt.php", found_by: 'Known Locations') }
      let(:tt2)       { timthumb.new("#{target_url}tt2.php", found_by: 'Known Locations') }
      let(:timthumbs) { [tt, tt2] }

      context 'when not vulnerable' do
        let(:expected_view) { File.join(view, 'no_vulns') }

        it 'outputs the expected string' do
          expect(timthumbs[0]).to receive(:version).at_least(1).and_return(version)
          expect(timthumbs[1]).to receive(:version).at_least(1).and_return(version)

          @tpl_vars = tpl_vars.merge(timthumbs: timthumbs)
        end
      end

      context 'when vulnerable' do
        let(:expected_view) { File.join(view, 'with_vulns') }

        it 'outputs the expected string' do
          expect(timthumbs[0]).to receive(:version).at_least(1).and_return(false)
          expect(timthumbs[1]).to receive(:version).at_least(1).and_return(version)

          @tpl_vars = tpl_vars.merge(timthumbs: timthumbs)
        end
      end
    end
  end
end
