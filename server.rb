require_relative 'database'
require 'sinatra/base'
require 'rack-flash'

class Chitter < Sinatra::Base
	helpers UserSession

	enable :sessions
	set :session_secret, 'super secret'
	use Rack::Flash
	# use Rack::MethodOveride

	get '/' do 
		flash[:errors] = nil
		@peeps = Peep.all
		erb :index
	end

	post '/peep' do
		body = params["body"]
		time_stamp = Time.now
		current_user.peeps.create(:body => body, :time_stamp => time_stamp)
		redirect '/'
	end

	get '/sessions/new' do
		erb :"sessions/new"
	end

	post '/sessions' do
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect '/'
		else
			flash[:errors] = ["The email or password is incorrect"]
			erb :"sessions/new"
		end
	end

	post '/logout' do
		session[:user_id] = nil
		erb :"users/out"
	end

	get '/users/new' do
		@user = User.new
		erb :"users/new"
	end

	post '/users' do
		@user = User.create(:name => params[:name],
												:username => params[:username],
												:email => params[:email],
												:password => params[:password],
												:password_confirmation => params[:password_confirmation])

		if @user.save
			session[:user_id] = @user.id 
			redirect '/'
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :"users/new"
		end
	end






run! if app_file == $0
end