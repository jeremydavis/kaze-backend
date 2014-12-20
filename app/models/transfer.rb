class Transfer < ActiveRecord::Base
  belongs_to :account
  belongs_to :payee
  belongs_to :currency

  attr_accessor :transaction_password

  validates :account_id,
            :payee_id,
            :currency_id,
            :value,
            :description,
            :transfer_date,
            :transaction_password,
            { presence: true }
  validate :transfer_date_is_in_the_future, if: :transfer_date
  validate :repeat_until_date_is_after_transfer_date, if: :repeat?
  validate :confirm_transaction_password, if: :transaction_password

  after_validation :clear_transaction_password, if: :transaction_password

  private
  def transfer_date_is_in_the_future
    if self.transfer_date <= Date.today
      errors.add(:transfer_date, 'Transfer Date cannot be in the past')
    end
  end
  def repeat_until_date_is_after_transfer_date
    if !self.repeat_until || self.repeat_until <= (self.transfer_date >> 1)
      errors.add(:repeat_until, 'Repeat transfers must last for at least 1 month')
    end
  end
  def confirm_transaction_password
    case self.transaction_password
    when '1234'
      errors.add(:transaction_password, 'Password Expired')
    when '234wer'
      self.transaction_password_valid = true
    else
      errors.add(:transaction_password, "Password Invalid #{self.transaction_password}")
    end
  end
  def clear_transaction_password
    self.transaction_password = nil
  end
end
