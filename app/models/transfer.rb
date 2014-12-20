class Transfer < ActiveRecord::Base
  belongs_to :account
  belongs_to :payee
  belongs_to :currency

  validates :account_id, :payee_id, :currency_id, :value, :description, :transfer_date, presence: true
  validate :transfer_date_is_in_the_future, if: :transfer_date
  validate :repeat_until_date_is_after_transfer_date, if: :repeat?

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
end
