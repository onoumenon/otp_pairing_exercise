class Otp < ApplicationRecord
  validates :phone_number, presence: true, length: { is: 8 }
  validates :otp, presence: true, length: { is: 6 }
end
