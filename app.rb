require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
require './models'

# to generate a random string in the irb:
# require 'securerandom'
# SecureRandom.hex
set :session_secret, ENV['X']
enable :sessions

get '/' do
  user = User.find_by(username: params[:username])
  unless session[:user_id].nil?
  # if user_id is found, define @user globally
    @user = User.find(session[:user_id])
    @posts = Post.all.reverse
  end
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    birthday: params[:birthday]
  )
  session[:user_id] = @user.id
  redirect '/'
end

get '/log_in' do
  erb :log_in
end

post '/log_in' do
  user = User.find_by(username: params[:username])

  if user.nil?
  # if username does not exit, show warning
    flash[:warning] = "Username does not exist. Please sign up for an account."
    redirect 'log_in'
  elsif 
    unless user && user.password == params[:password]
    # if username and password are incorrect, show warning
      flash[:warning] = "Username and password combination is incorrect."
      redirect '/log_in'
    end
  end
  session[:user_id] = user.id
  flash[:sucess] = "Signed in as #{user.username}."
  redirect '/'
end

get '/settings' do
  erb :settings
end

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/edit_account/:id' do
  @user = User.find(params[:id])
  erb :edit_account
end

post '/edit_account' do
  @user = User.update(
    username: params[:username],
    password: params[:password],
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    birthday: params[:birthday]
  )

  redirect "/profile/#{session[:user_id]}"
end

get '/log_out' do
  session[:user_id] = nil
  flash[:info] = "Signed out."
  redirect '/'
end

get '/delete_account' do
  user = User.find(session[:user_id])
  posts =  Post.where(user_id: user.id)
  unless posts.nil?
    user.posts.each do |p|
      Post.destroy(p.id)
    end
  end
  User.destroy(session[:user_id])
  session[:user_id] = nil
  flash[:warning] = "Account deleted."
  redirect "/"
end

get '/new_post' do
  @user = User.find(session[:user_id])
  erb :new_post
end

post '/new_post' do
  @user = User.find(session[:user_id])
  @post = Post.create(
    user_id: @user.id,
    title: params[:title],
    post: params[:post],
  )
  flash[:sucecess] = "Post '#{params[:title]}' has been published."
  redirect '/'
end

get '/edit_post/:id' do
  @user = User.find(session[:user_id])
  @post = Post.find(params[:id])
  erb :edit_post
end

post '/edit_post/:id' do
  @post = Post.find(params[:id])
  Post.update(
    title: params[:title],
    post: params[:post],
  )
  redirect '/my_posts'
end

get '/my_posts' do
  @user = User.find(session[:user_id])
  @my_posts =  Post.where(user_id: @user.id)
  erb :my_posts
end

get '/delete_post/:id' do
  @user = User.find(session[:user_id])
  post = Post.find(params[:id])
  Post.destroy(post.id)
  flash[:warning] = "Post '#{post.title}' has been deleted."
  redirect '/my_posts'
end


