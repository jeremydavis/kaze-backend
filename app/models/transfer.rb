class Transfer < ActiveRecord::Base
  include Confirmable

  belongs_to :account
  belongs_to :payee
  belongs_to :currency

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

  validates_format_of :value, with: /\A\d+\.?\d{0,2}\z/, message: 'maximum of 2 decimal places'

  before_create :set_status_as_submitted

  # List of keys used for transactino confirmation
  def transaction_keys
    [
      :account_id,
      :payee_id,
      :currency_id,
      :value,
      :description,
      :transfer_date,
      :repeat,
      :repeat_until,
      :initiated_at
    ]
  end

  private
  def transfer_date_is_in_the_future
    if self.transfer_date < Date.today
      errors.add(:transfer_date, 'Transfer Date cannot be in the past')
    end
  end
  def repeat_until_date_is_after_transfer_date
    if !self.repeat_until || self.repeat_until < (self.transfer_date >> 1)
      errors.add(:repeat_until, 'Repeat transfers must last for at least 1 month')
    end
  end

  def set_status_as_submitted
    raise "Invalid starting status for transaction: '#{self.status}'" unless self.status.blank?
    self.status = 'SUBMITTED'
    self.submitted_at = Time.now
 end
end
