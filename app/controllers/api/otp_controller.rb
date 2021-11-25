class Api::OtpController < ApplicationController
  def create
    params = {
      phone_number: phone_number_param,
      expiry_date: DateTime.now + 20.seconds,
      otp: rand(100_000..999_999).to_s
    }

    if Otp.create(params).valid?
      render json: params, status: :created
    else
      render json: { message: 'invalid phone number' }, status: :bad_request
    end
  end

  def verify
    # TODO: add is_used column to check if otp has been used
    otp = Otp.find_by(otp: otp_param, phone_number: phone_number_param)
    if otp.present?
      if DateTime.now.before?(otp.expiry_date)
        render status: :ok
      else
        render json: { message: 'otp is expired' }, status: :unauthorized
      end

    else
      render json: { message: 'not found' }, status: :not_found
    end
  end

  private

  def phone_number_param
    params[:phone_number]
  end

  def otp_param
    params[:otp]
  end
end
