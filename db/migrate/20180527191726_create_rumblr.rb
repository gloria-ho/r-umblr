class CreateRumblr < ActiveRecord::Migration[5.2]
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

      create_table :posts do |post|
        post.integer :user_id
        post.string :title
        post.string :post
        post.datetime :created_at
        post.datetime :updated_at
      end
  end
end