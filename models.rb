require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false }
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end