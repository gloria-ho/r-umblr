class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :first_name
      user.string :last_name
      user.string :email
      user.string :username
      user.string :password
      user.date :birthday
      user.datetime :created_at
    end
  end
end