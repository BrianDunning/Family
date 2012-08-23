class Familyname < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :sex, :firstname, :lastname

  attr_protected :id

  def name
  	"#{firstname} #{lastname}"
  end

  def fullname
  	"#{firstname} #{middlenames} #{lastname}"
  end

  def namewid
  	"#{firstname} #{lastname} (#{id})"
  end

  def fullnamewid
  	"#{firstname} #{middlenames} #{lastname} (#{id})"
  end

  def genders
    return ["M", "F"]
  end
end
