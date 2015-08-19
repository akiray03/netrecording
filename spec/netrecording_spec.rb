require 'spec_helper'

describe Netrecording do
  it 'has a version number' do
    expect(Netrecording::VERSION).not_to be nil
  end

  describe 'with recording' do
    before do
      Netrecording.clear_records!
      Netrecording.start_recording!
    end
    after do
      Netrecording.stop_recording!
    end

    it { expect(Netrecording).to be_recording }

    context'records' do
      let(:uri) { URI.parse 'http://www.google.com/' }
      let(:request)  { Net::HTTP::Get.new(uri.path) }
      let(:response) { Net::HTTP.start(uri.host, uri.port) {|h| h.request(request) } }

      subject { Netrecording.records }
      it { expect(subject).to be_empty }
      it { response.body; expect(subject).not_to be_empty }

      it 'contents' do
        res_body = response.body
        expect(subject[0][:response].body).to eq res_body
        expect(subject[0][:path]).to eq uri.to_s
      end
    end
  end
end
