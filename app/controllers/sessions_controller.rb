class SessionsController < ApplicationController
  def new; end 

  def create
    user = User.find_by(username: params[:username])

    if user&.login_failure_count == 3
      redirect_to root_path, alert: 'Too many failed login attempts.'
      return
    end

    if user&.authenticate(params[:password])
      user.login_failure_count = 0
      user.save
      session[:user_id] = user.id 
      redirect_to root_path, notice: 'You have logged in.'
    else
      user&.login_failure_count += 1
      user&.save
      flash[:alert] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end  
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have been logged out.'
  end
end
