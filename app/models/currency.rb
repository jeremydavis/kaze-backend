class Currency < ActiveRecord::Base
  validates :shortname, :longname, presence: true, uniqueness: true
  before_validation :normalise_names

  has_many :accounts
  has_many :transfers

  def to_label
    return "#{self.shortname} - #{self.longname}"
  end

  private
  def normalise_names
    self.shortname = self.shortname.upcase
  end
end
