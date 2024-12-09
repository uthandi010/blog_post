class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # the user_params get input from the user// User.new it is user table this input value stored hen generate the user_id//
    if @user.save  # it will check the @user is saved // it will true then execute the block //
      member_role = Role.find_by(name: "MEMBER")  # the member_role is variable to stored roles table have a name column on the value is "member" find onthe table to get the all value to store //
      @user.roles << member_role if member_role  # the if condition is member_role have a value this condition is true // @user.roles. << member_role roles is through user_roles table to create to current user_id and roles_id to generate //
      sign_in(@user)  #it is create the remember token is generate this is on application inside the cookies to stored // 
      redirect_to root_path, notice: "Welcome, #{@user.first_name}!" #it is redirect the root_path...//
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def profile
   
    @user = User.find(params[:id])
    @user_posts = @user.blog_posts
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
