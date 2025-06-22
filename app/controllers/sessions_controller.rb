class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.role == "receptionist"
        redirect_to receptionist_dashboard_path
      elsif user.role == "doctor"
        redirect_to doctor_dashboard_path
      else
        redirect_to root_path, notice: "Role not recognized"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
