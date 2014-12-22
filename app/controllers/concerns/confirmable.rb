module Confirmable
  extend ActiveSupport::Concern

  included do
    attr_accessor :transaction_password
    attr_accessor :one_time_password
    attr_accessor :transaction_hash
    attr_accessor :otp_was_requested

    validates_presence_of :transaction_password, if: -> { self.transaction_hash.blank? }, on: :create
    validate  :confirm_transaction_password, on: :create
    validate  :confirm_transaction_hash, unless: -> { self.transaction_hash.blank? }, on: :create
    validate  :confirm_one_time_password, on: :create

    after_validation :clear_transaction_password, if: :transaction_password
    after_validation :clear_one_time_password, if: :one_time_password

    before_save :abort_if_validity_flags_not_set
  end

  def request_one_time_password
    self.otp_was_requested = true
  end

  private
    def confirm_transaction_password
      return unless self.transaction_hash.blank?
      case transaction_password
      when '123'
        errors.add :transaction_password, 'Transaction Password Expired'
      when '123qwe'
        self.initiated_at = Time.now
        self.transaction_password_valid = true
        self.transaction_hash = calculate_transaction_hash(transaction_params)
        request_one_time_password
      else
        errors.add :transaction_password, "Transaction Password Invalid"
      end
    end

    def confirm_transaction_hash
      if valid_transaction_hash? transaction_params, transaction_hash
        self.transaction_password_valid = true
      else
        self.transaction_hash = nil
        self.initiated_at = nil
        errors.add :transaction_password, "Transaction Details Changed After Transaction Password Confirmed"
      end
    end

    def confirm_one_time_password
      case one_time_password
      when '1234'
        errors.add :one_time_password, 'One Time Password Expired'
      when '1234qwer'
        self.one_time_password_valid = true
      else
        errors.add :one_time_password, "One Time Password Invalid"
      end
    end

    def transaction_params
      params_hash = {}
      transaction_keys.each {|k|
        params_hash[k] = self.send(k)
      }
      return params_hash
    end

    def secret_transaction_key
      @@secret_transaction_key ||= ENV["SECRET_CONFIRM_KEY"] ||= '1234'
    end

    def calculate_transaction_hash transaction
      payload = "#{secret_transaction_key} #{transaction.to_json} #{secret_transaction_key}"
      Digest::SHA2.new.update(payload)
    end

    def valid_transaction_hash? transaction, transaction_hash
      calculate_transaction_hash(transaction) == transaction_hash
    end

    def clear_transaction_password
      self.transaction_password = nil
    end

    def clear_one_time_password
      self.one_time_password = nil
    end

    def abort_if_validity_flags_not_set
      raise 'Transaction Flags failed to be set' unless self.transaction_password_valid? && self.one_time_password_valid?
    end

  # methods to extend the class
  # module ClassMethods
  # end
end
