class Payee < ActiveRecord::Base
  validates :nickname, :account_holder, :account_number, :bank_name, :branch_name, presence: true
  before_validation :normalise_account_number

  private
  def normalise_account_number
    self.account_number = self.account_number.tr("^0-9", '')
  end
end
