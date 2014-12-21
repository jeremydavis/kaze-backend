class Transfer < ActiveRecord::Base
  belongs_to :account
  belongs_to :payee
  belongs_to :currency

  attr_accessor :transaction_password

  after_initialize do
    self.transfer_date = Date.today if self.new_record?
  end

  validates :account_id,
            :payee_id,
            :currency_id,
            :value,
            :description,
            :transfer_date,
            { presence: true }
  validate :transfer_date_is_in_the_future, if: :transfer_date, on: :create
  validate :repeat_until_date_is_after_transfer_date, if: :repeat?

  validates_presence_of :transaction_password, on: :create
  validate :confirm_transaction_password, unless: :transaction_password_valid?

  after_validation :clear_transaction_password, if: :transaction_password

  before_create :set_status_as_submitted

  private
  def transfer_date_is_in_the_future
    if self.transfer_date < Date.today
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
      errors.add(:transaction_password, 'Transaction Password Expired')
    when '234wer'
      self.transaction_password_valid = true
    else
      errors.add(:transaction_password, "Transaction Password Invalid")
    end
  end
  def clear_transaction_password
    self.transaction_password = nil
  end
  def set_status_as_submitted
    raise "Invalid starting status for transaction: '#{self.status}'" unless self.status.blank?
    self.status = 'SUBMITTED'
    self.submitted_at = Time.now
 end
end
