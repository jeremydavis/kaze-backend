class Account < ActiveRecord::Base
  before_validation :normalise_account_number
  belongs_to :currency

  private
  def normalise_account_number
    self.account_number = self.account_number.tr("^0-9", '')
  end
end
