class Currency < ActiveRecord::Base
  has_many :accounts
  has_many :transfers

  before_validation :normalise_names
  validates :shortname, :longname, presence: true, uniqueness: true

  def to_label
    return "#{self.shortname} - #{self.longname}"
  end

  private
  def normalise_names
    self.shortname = self.shortname.upcase
  end
end
