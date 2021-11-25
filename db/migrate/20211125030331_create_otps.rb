class CreateOtps < ActiveRecord::Migration[6.1]
  def change
    create_table :otps do |t|
      t.string :phone_number
      t.datetime :expiry_date
      t.string :otp

      t.timestamps
    end
  end
end
