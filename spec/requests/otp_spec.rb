require 'rails_helper'

RSpec.describe 'Otp Requests', type: :request do
  describe 'POST /otp' do
    let(:phone_number) { '87532542' }
    before do
      post api_otp_path(phone_number: phone_number)
    end

    context 'when phone number is valid' do
      it do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['otp'].length).to eq(6)
        expect(JSON.parse(response.body)['phone_number'].length).to eq(8)
        expect(JSON.parse(response.body)['expiry_date'].length).not_to be_nil
      end
    end

    context 'when phone number is invalid' do
      let!(:phone_number) { '875325421' }

      it do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('invalid phone number')
      end
    end
  end

  describe 'GET /otp/verify' do
    let(:phone_number) { '87532542' }
    let(:otp) { 'invalid_otp' }
    before do
      get api_otp_verify_path(phone_number: phone_number, otp: otp)
    end

    context 'when otp is invalid' do
      it do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('not found')
      end
    end

    # TODO: test for valid otp

    # TODO: test for expired otp with timetravel

    # TODO: test for used otp
  end
end
