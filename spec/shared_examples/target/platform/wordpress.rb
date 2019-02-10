require_relative 'wordpress/custom_directories'

shared_examples WPScan::Target::Platform::WordPress do
  it_behaves_like 'WordPress::CustomDirectories'

  let(:fixtures) { FIXTURES.join('target', 'platform', 'wordpress') }

  describe '#wordpress?' do
    let(:fixtures) { super().join('detection') }

    before do
      stub_request(:get, target.url).to_return(body: File.read(fixtures.join("#{homepage}.html")))
    end

    context 'when pattern/s in the homepage' do
      %w[default wp_includes only_scripts meta_generator comments mu_plugins].each do |file|
        context "when a wordpress page (#{file}.html)" do
          let(:homepage) { file }

          it 'returns true' do
            expect(subject.wordpress?(:mixed)).to be true
          end
        end
      end
    end

    context 'when no clues in the homepage' do
      let(:homepage) { 'not_wp' }

      context 'when only passive detection mode' do
        it 'returns false' do
          expect(subject.wordpress?(:passive)).to be false
        end
      end

      context 'when mixed or aggressive detection modes' do
        context 'when wp-admin/install.php and wp-login.php not there' do
          it 'returns false' do
            %w[wp-admin/install.php wp-login.php].each do |path|
              stub_request(:get, target.url(path)).to_return(status: 404)
            end

            expect(subject.wordpress?(:mixed)).to be false
          end
        end

        context 'when wp-admin/install.php is matching a WP install' do
          it 'returns true' do
            stub_request(:get, target.url('wp-admin/install.php'))
              .to_return(body: File.read(fixtures.join('wp-admin-install.php')))

            expect(subject.wordpress?(:mixed)).to be true
          end
        end

        context 'when wp-admin/install.php not there but wp-login.php is matching a WP install' do
          it 'returns true' do
            stub_request(:get, target.url('wp-admin/install.php')).to_return(status: 404)
            stub_request(:get, target.url('wp-login.php'))
              .to_return(body: File.read(fixtures.join('wp-login.php')))

            expect(subject.wordpress?(:mixed)).to be true
          end
        end
      end
    end
  end

  describe '#wordpress_hosted?' do
    its(:wordpress_hosted?) { should be false }

    context 'when the target host matches' do
      let(:url) { 'http://ex.wordpress.com' }

      its(:wordpress_hosted?) { should be true }
    end

    context 'when the target host doesn\'t matches' do
      let(:url) { 'http://ex-wordpress.com' }

      its(:wordpress_hosted?) { should be false }
    end
  end
end
