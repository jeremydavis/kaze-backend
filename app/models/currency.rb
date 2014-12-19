class Currency < ActiveRecord::Base
  validates :shortname, :longname, presence: true
  before_validation :upcase_shortname

  private
  def upcase_shortname
    self.shortname = self.shortname.upcase
  end
end
