class SessionsController < Clearance::SessionsController

  def create
    user = authenticate(params)         # it will check first to email and password // then User.find_by(email:"inputmail") to stored to user variable //
    if user             # it will check the user's value is present  // it will true then execute the block //
      sign_in(user)                   #it is create the remember token is generate this is on application inside the cookies to stored // 
      redirect_to root_path, notice: "Signed in successfully!"            #it is redirect the root_path...//
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unauthorized
    end
  end 

  def destroy
    sign_out
    redirect_to root_path, notice: "You have successfully signed out."
  end
end
