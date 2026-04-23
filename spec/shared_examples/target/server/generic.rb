# frozen_string_literal: true

shared_examples WPScan::Target::Server::Generic do
  describe '#server' do
    before { stub_request(:head, target.url).to_return(headers: parse_headers_file(fixture)) }

    context 'when apache headers' do
      %w[basic.txt].each do |file|
        context "when #{file} headers" do
          let(:fixture) { fixtures.join('server', 'apache', file) }

          its(:server) { should eq :Apache }
        end
      end
    end

    context 'when iis headers' do
      %w[basic.txt].each do |file|
        context "when #{file} headers" do
          let(:fixture) { fixtures.join('server', 'iis', file) }

          its(:server) { should eq :IIS }
        end
      end
    end

    context 'when nginx headers' do
      %w[basic.txt].each do |file|
        context "when #{file} headers" do
          let(:fixture) { fixtures.join('server', 'nginx', file) }

          its(:server) { should eq :Nginx }
        end
      end
    end

    context 'not detected' do
      let(:fixture) { fixtures.join('server', 'not_detected.txt') }

      its(:server) { should be nil }
    end
  end

  describe '#directory_listing?' do
    # Handled in shared_examples/target/server/apache & nginx
  end
end
