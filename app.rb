require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
require './models'

# to generate a random string in the irb:
# require 'securerandom'
# SecureRandom.hex
set :session_secret, ENV['RUMBLR_SESSION_SECRET']
enable :sessions

get '/' do
  user = User.find_by(username: params[:username])
  unless session[:user_id].nil?
  # if user_id is found, define @user globally
    @user = User.find(session[:user_id])
    @posts = Post.all.limit(20).reverse
  end
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  # ok each one of these User.where searches the database for a matching user so in total we're doing
  # this 4 times. We could simply this a little by doing the checks first and return if they fail
  
  # if User.where(username: params[:username].downcase).present?
  #   flash[:warning] = "Username already exists, please try a different username."
  #   return redirect '/sign_up'
  # end
  # if User.where(email: params[:email].downcase).present?
  #   flash[:warning] = "Email is already registered. Please log in."
  #   return redirect '/sign_up'
  # end

  # if both checks fail then we can create the user without having to check it again.

  # @user = User.create(
  #   username: params[:username],
  #   password: params[:password],
  #   first_name: params[:first_name],
  #   last_name: params[:last_name],
  #   email: params[:email],
  #   birthday: params[:birthday]
  # )
  # session[:user_id] = @user.id
  # flash[:success] = "Thank you for signing up, #{@user.first_name}!"
  # redirect '/'

  unless User.where(username: params[:username].downcase).present? || User.where(email: params[:email].downcase).present?
    @user = User.create(
      username: params[:username],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      birthday: params[:birthday]
    )
    session[:user_id] = @user.id
    flash[:success] = "Thank you for signing up, #{@user.first_name}!"
    redirect '/'
  end
  if User.where(username: params[:username].downcase).present?
  # if username is not unique, display error
    flash[:warning] = "Username already exists, please try a different username."
    redirect '/sign_up'
  end
  if User.where(email: params[:email].downcase).present?
  # if email is not unique, display error
    flash[:warning] = "Email is already registered. Please log in."
    redirect '/sign_up'
  end
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
  elsif # we need a condition here for elsif.  Should look like elsif condition
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

get '/profile/:id' do
  # should probably check if the user is logged in here before showing them a profile page
  @user = User.find(params[:id])
  erb :profile
end

get '/edit_account/:id' do
  # should probably check if the user is logged in here
  @user = User.find(params[:id])
  erb :edit_account
end

post '/edit_account' do
  # should probably check if the user is logged in here
  # calling User.update will update *all* users in our database.
  # should first find the user by id and then update only that instnace

  # @user = User.find(session[:user_id])
  # @user.update(...) 
  # look at what you did below for post edit
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
  unless posts.nil? # when you call .where you will always get back an array so it will never be nil
    # if you want to check that there are posts do "posts.empty?"
    user.posts.each do |p|
      Post.destroy(p.id)
    end
  end
  User.destroy(session[:user_id])
  session[:user_id] = nil
  flash[:warning] = "Account #{user.username} and all posts have been deleted."
  redirect "/"
end

get '/new_post' do
  # should probably check user is logged in here
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
  flash[:success] = "Post '#{params[:title]}' has been published."
  redirect '/'
end

get '/edit_post/:id' do
  @user = User.find(session[:user_id])
  @post = Post.find(params[:id])
  erb :edit_post
end

post '/edit_post/:id' do
  @post = Post.find(params[:id])
  @post.update(
    title: params[:title],
    post: params[:post],
  )
  flash[:success] = "Post '#{params[:title]}' has been updated."
  redirect '/my_posts'
end

get '/my_posts' do
  @user = User.find(session[:user_id])
  # because we defined the has_many :posts on the user model we can do the following:
  # @my_posts = @user.posts instead of doing the Post.where
  @my_posts =  Post.where(user_id: @user.id)
  erb :my_posts
end

get '/delete_post/:id' do
  @user = User.find(session[:user_id]) # do we need to do this???
  post = Post.find(params[:id])
  Post.destroy(post.id)
  flash[:warning] = "Post '#{post.title}' has been deleted."
  redirect '/my_posts'
end