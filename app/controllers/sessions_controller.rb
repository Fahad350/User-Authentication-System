class SessionsController < ApplicationController
  def new
  end
  def create
    #binding.pry
    #if params[:session][:remember_me] == "1"
      user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password]) 
      # session[:user_id] = user.id
      # redirect_to user_path(user)
          forwarding_url = session[:forwarding_url]
            reset_session
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            remember user
            log_in user
            redirect_to forwarding_url || user
          
        else
          flash.now[:danger] = "Invalid email/password combination"
          render :new, status: :unprocessable_entity
        end
   # else
    
   # flash.now[:notice] = "user login if remember me checked"
   # render :new, status: :unprocessable_entity
   # end
end

def destroy
  log_out if logged_in?
 
  redirect_to login_url
end
end
