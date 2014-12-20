class Account < ActiveRecord::Base
  before_validation :normalise_account_number

  belongs_to :currency
  has_many :transfers

  def to_label
    return "#{self.account_number} - #{self.currency.try(:shortname)} #{self.balance}"
  end

  private
  def normalise_account_number
    self.account_number = self.account_number.tr("^0-9", '')
  end
end
