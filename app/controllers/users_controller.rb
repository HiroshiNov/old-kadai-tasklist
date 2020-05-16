class UsersController < ApplicationController
  # def index
  # end

  # def show
  # end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] ="ユーザ登録に成功しました"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash.now[:danger] ="ユーザ登録に失敗しました"
      render :new
    end
  end

  def new
    @user = User.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
