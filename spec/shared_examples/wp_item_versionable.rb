# encoding: UTF-8

shared_examples 'WpItem::Versionable' do

  describe '#version' do
    let(:fixtures_dir) { MODELS_FIXTURES + '/wp_item/versionable' }
    let(:readme_url)   { subject.uri.merge('readme.txt').to_s }

    context 'when the version is already set' do
      it 'returns it' do
        subject.version = '1.2'
        expect(subject.version).to eq '1.2'
      end
    end

    context 'otherwise' do
      after do
        stub_request_to_fixture(url: readme_url, fixture: fixtures_dir + @file)
        expect(subject.version).to eq @expected
      end

      context 'when version is "trunk"' do
        it 'returns nil' do
          @file     = '/trunk-version.txt'
          @expected = nil
        end
      end

      context 'when the version is valid' do
        context 'when leaked from the stable tag' do
          it 'returns it' do
            @file     = '/simple-login-lockdown-0.4.txt'
            @expected = '0.4'
          end
        end

        context 'when leaked from the version' do
          it 'returns it' do
            @file     = '/wp-photo-plus-5.1.15.txt'
            @expected = '5.1.15'
          end
        end

        context 'when version is in a release date format' do
          it 'detects and returns it' do
            @file     = '/s2member.txt'
            @expected = '141007'
          end
        end

        context 'when version contains letters' do
          it 'returns it' do
            @file     = '/beta1.txt'
            @expected = '2.0.0-beta1'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/changelog_version.txt'
            @expected = '1.3'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/wp_polls.txt'
            @expected = '2.64'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/nextgen_gallery.txt'
            @expected = '2.0.66.33'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/wp_user_frontend.txt'
            @expected = '1.2.3'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/my_calendar.txt'
            @expected = '2.1.5'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/nextgen_gallery_2.txt'
            @expected = '1.9.13'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/advanced-most-recent-posts-mod.txt'
            @expected = '1.6.5.2'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/a-lead-capture-contact-form-and-tab-button-by-awebvoicecom.txt'
            @expected = '3.1'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/aa-health-calculator.txt'
            @expected = nil
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/all-in-one-facebook.txt'
            @expected = nil
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/backup-scheduler.txt'
            @expected = '1.5.9'
          end
        end

        context 'when parsing the changelog for version numbers' do
          it 'returns it' do
            @file     = '/blog-reordering.txt'
            @expected = nil
          end
        end

        #  context 'when parsing the changelog for version numbers with dates' do
        #   it 'returns it' do
        #     @file     = '/wp-maintenance-mode.txt'
        #     @expected = '2.0.9'
        #   end
        # end
      end
    end
  end

  describe '#to_s' do
    after do
      allow(subject).to receive(:version).and_return(@version)
      subject.name = 'some-name'

      expect(subject.to_s).to eq @expected
    end

    context 'when the version does not exist' do
      it 'returns only the name' do
        @version = nil
        @expected = 'some-name'
      end
    end

    context 'when the version exists' do
      it 'returns the name and the version' do
        @version  = '1.3'
        @expected = 'some-name - v1.3'
      end
    end
  end

end
