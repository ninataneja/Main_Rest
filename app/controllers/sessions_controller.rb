class SessionsController < ApplicationController


  def signin
    @user = User.new
  end

  def create
    if auth
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
           u.image = auth['info']['image']
        end
         # binding.pry
         @user.save(validate: false)
       session[:user_id] = @user.id
       redirect_to new_trip_path
    else
    @user = User.find_by(email: params[:user][:email])
     if @user
       if  @user.authenticate(params[:user][:password])

      session[:user_id] = @user.id
      session[:total] = 0
      redirect_to new_trip_path
    else
       # binding.pry
    flash[:notice] = "Email or password is invalid"
    redirect_to :signin
    end
   end
 end
 end


  def destroy
    session[:user_id] = nil
    session[:trip_id] = nil
    session[:total] = 0

    # reset_session
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
