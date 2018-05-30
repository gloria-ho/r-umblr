require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './models'

# to generate a random string in the irb:
#  require 'securerandom'
#  SecureRandom.hex
set :session_secret, ENV['RUMBLR_SESSION_SECRET']
enable :sessions

get '/' do
  user_id = User.find_by(username: params[:username])
  unless user_id.nil?
    @user = User.find(session[:user_id])
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
    flash[:warning] = "Username does not exist. Please sign up for an account."
    redirect 'log_in'
  elsif 
    unless user && user.password == params[:password]
      flash[:warning] = "Username and password combination is incorrect."
      redirect '/log_in'
    end
  end
  
  session[:user_id] = user.id
  flash[:sucess] = "Signed in as #{user.username}."
  redirect '/'
end

get '/feed' do

  user_id = session[:user_id]
  if user_id.nil?
    redirect '/'
  end

  @user = User.find(user_id)

  erb :feed
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

get 'sign_out' do

  redirect '/'
end

get '/delete_account/:id' do

end
