require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false }

end

class Post < ActiveRecord::Base

end