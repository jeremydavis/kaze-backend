class Currency < ActiveRecord::Base
  validates :shortname, :longname, presence: true, uniqueness: true
  before_validation :normalise_names

  private
  def normalise_names
    self.shortname = self.shortname.upcase
    self.longname = self.longname.titleize
  end
end
