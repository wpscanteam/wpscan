# frozen_string_literal: true

shared_examples WPScan::Target::Server::IIS do
  describe '#server' do
    its(:server) { should eq :IIS }
  end

  describe '#directory_listing?, #directory_listing_entries' do
    before     { stub_request(:get, target.url(path)).to_return(body: body, status: status) }
    let(:path) { 'dir' }

    context 'when not a 200' do
      let(:status) { 404 }
      let(:body)   { '' }

      it 'returns false and an empty array' do
        expect(target.directory_listing?(path)).to be false
        expect(target.directory_listing_entries(path)).to eql []
      end
    end

    context 'when 200' do
      let(:status) { 200 }

      %w[with_parent.html no_parent.html].each do |file|
        context "when #{file} body" do
          let(:body)   { File.read(fixtures.join('directory_listing', file)) }

          it 'returns true and the expected array' do
            expect(target.directory_listing?(path)).to be true
            expect(target.directory_listing_entries(path)).to eq %w[sub-dir web.config]
          end
        end
      end
    end
  end
end
