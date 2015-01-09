class SessionsController < ApplicationController

  skip_before_action :authorize

  def new
  end

  def create

    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password]) #the method authenticate
      # authenticates a +req+ and returns a 401 Unauthorized using +res+ if
      # the authentication was not correct.
      session[:user_id] = user.id
      redirect_to admin_index_url

    else
      redirect_to login_url, alert: "Invalid user/password combination"

    end

  end

  def destroy
     session[:user_id] = nil

    redirect_to store_url, notice: 'You  logged out'

  end
end
