class Transfer < ActiveRecord::Base
  belongs_to :account
  belongs_to :payee
  belongs_to :currency
end
