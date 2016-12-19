class User < ActiveRecord::Base
  has_secure_password
  has_many :books
  has_many :authors, through: :books
  validates :email, :name, presence: true
  validates :email, uniqueness: true

  def slug
    self.name.gsub(" ","-")
  end

  def self.find_by_slug(arg)
    new_arg = arg.gsub("-"," ")
    User.find_by(name: new_arg )
  end
end
