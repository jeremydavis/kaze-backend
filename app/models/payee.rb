class Payee < ActiveRecord::Base
  validates :nickname, :account_holder, :account_number, :bank_name, :branch_name, presence: true
  before_validation :normalise_account_number

  has_many :transfers

  def to_label
    return "#{self.nickname} - #{self.account_number}"
  end

  private
  def normalise_account_number
    self.account_number = self.account_number.tr("^0-9", '')
  end
end
