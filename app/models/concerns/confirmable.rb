module Confirmable
  extend ActiveSupport::Concern

  included do
    attr_accessor :transaction_password
    attr_accessor :one_time_password
    attr_accessor :transaction_hash
    attr_accessor :otp_was_requested

    after_validation on: :create do
      confirm_transaction!
      clear_transaction_password!
      clear_one_time_password!
    end

    before_save :abort_if_validity_flags_not_set
  end

  def confirm_transaction_params
    ( self.transaction_keys & self.errors.messages.keys ).empty?
  end
  def confirm_transaction_hash
    TxnSystem.valid_transaction_hash?(transaction_params, transaction_hash)
  end
  def confirm_transaction_password
    TxnSystem.valid_transaction_password? self.transaction_password
  end
  def confirm_one_time_password
    OtpSystem.valid_one_time_password? self.one_time_password
  end

  def request_one_time_password!
    OtpSystem.request_one_time_password
    self.otp_was_requested = true
    errors.add :one_time_password, 'Please enter the OTP sent to your phone'
  end

  private

    def confirm_transaction!
      if self.transaction_hash.blank?
        return unless confirm_transaction_params!
        return unless confirm_transaction_password!
        set_transaction_hash!
        request_one_time_password!
      else
        return unless confirm_transaction_hash!
        confirm_one_time_password!
      end
    end

    def only_otp_or_txn_not_both
      clear_one_time_password if !self.transaction_password.blank? && !self.one_time_password.blank?
    end

    def confirm_transaction_params!
      if confirm_transaction_params
        return valid_transaction_params!
      else
        return invalid_transaction_params!
      end
    end
    def valid_transaction_params!
      return true
    end
    def invalid_transaction_params!
      if self.transaction_password.blank?
        errors.add :transaction_password_valid, 'Required'
        return false
      else
        errors.add :transaction_password, 'Please complete all fields before entering Transaction Password'
        return false
      end
    end

    def confirm_transaction_hash!
      if confirm_transaction_hash
        return valid_transaction_hash!
      else
        return invalid_transaction_hash!
      end
    end
    def valid_transaction_hash!
      self.transaction_password_valid = true
      return true
    end
    def invalid_transaction_hash!
      self.transaction_hash = nil
      self.initiated_at = nil
      errors.add :transaction_password, "Transaction Details Changed After Transaction Password Confirmed"
      return false
    end

    def confirm_transaction_password!
      if confirm_transaction_password
        return valid_transaction_password!
      else
        return invalid_transaction_password!
      end
    end
    def valid_transaction_password!
      self.transaction_password_valid = true
      return true
    end
    def invalid_transaction_password!
      if self.transaction_password.blank?
        errors.add :transaction_password, "Please enter your Transaction Password"
      else
        errors.add :transaction_password, "Transaction Password Invalid"
      end
      return false
    end

    def confirm_one_time_password!
      if confirm_one_time_password
        return valid_one_time_password!
      else
        return invalid_one_time_password
      end
    end
    def valid_one_time_password!
      self.one_time_password_valid = true
      return true
    end
    def invalid_one_time_password
      if self.one_time_password.blank?
        errors.add :one_time_password, "Please enter the OTP sent to your phone"
      else
        errors.add :one_time_password, "One Time Password Invalid"
      end
      return false
    end

    def set_transaction_hash!
      self.initiated_at = Time.now
      self.transaction_hash = TxnSystem.calculate_transaction_hash(transaction_params)
    end

    def transaction_params
      params_hash = {}
      transaction_keys.each {|k|
        params_hash[k] = self.send(k)
      }
      return params_hash
    end

    def clear_transaction_password!
      self.transaction_password = nil
    end

    def clear_one_time_password!
      self.one_time_password = nil
    end

    def abort_if_validity_flags_not_set
      raise 'Transaction Flags failed to be set' unless self.transaction_password_valid? && self.one_time_password_valid?
    end

  # methods to extend the class
  # module ClassMethods
  # end
end

class TxnSystem
  def self.valid_transaction_hash? transaction, transaction_hash
    generate_transaction_hash(transaction) == transaction_hash
  end

  def self.valid_transaction_password? password
    Rails.logger.debug("here")
    password == '123qwe'
  end

  def self.calculate_transaction_hash transaction
    generate_transaction_hash transaction
  end

  private
    def self.generate_transaction_hash transaction
      payload = "#{secret_transaction_key} #{transaction.to_json} #{secret_transaction_key}"
      Digest::SHA2.new.update(payload)
    end
    def self.secret_transaction_key
      @@secret_transaction_key ||= ENV["SECRET_CONFIRM_KEY"] ||= '1234'
    end
end

class OtpSystem
  def self.valid_one_time_password? password
    password == '1234qwer'
  end
  def self.request_one_time_password
    return true
  end
end