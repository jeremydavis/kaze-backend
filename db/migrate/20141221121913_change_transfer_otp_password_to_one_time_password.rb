class ChangeTransferOtpPasswordToOneTimePassword < ActiveRecord::Migration
  def change
    rename_column :transfers, :otp_password_valid, :one_time_password_valid
  end
end
