class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: :destroy
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def login
  end

 def signup
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    
  end

  def create
   # binding.pry
  @user = User.new(user_params)

  if @user.save
    reset_session
    log_in @user
    flash[:success] = "User Created!!"
    redirect_to @user, notice: "created user successfully!"
  else
    render :signup, status: :unprocessable_entity
  end
end

def update
   @user = User.find(params[:id])
if @user.update(user_params)
# Handle a successful update.
  flash[:success] = "Profile updated"
  redirect_to @user
else
  render 'edit', status: :unprocessable_entity
end
end

# Confirms a logged-in user.
def logged_in_user
 # binding.pry
unless logged_in?
  store_location
flash[:danger] = "Please log in."
redirect_to login_url, status: :see_other
end
end

   # Confirms the correct user.
def correct_user
  #binding.pry
  @user = User.find(params[:id])
  redirect_to(root_url, status: :see_other) unless current_user?(@user)
end

def destroy
User.find(params[:id]).destroy
flash[:success] = "User deleted"
redirect_to users_url, status: :see_other
end

 private

 # Confirms an admin user.
def admin_user
redirect_to(root_url, status: :see_other) unless
current_user.admin?
end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
