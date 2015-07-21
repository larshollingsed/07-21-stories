class UsersController < ApplicationController
  def list
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    name = params["user"]["name"]
    email = params["user"]["email"]
    prepassword = params["user"]["password"]
    password = BCrypt::Password.create(prepassword)
    @user = User.create({"name" => name, "email" => email, "password" => password})
    if @user.valid?
      redirect_to "/users/login"
    else
      render :"/users/new"
    end
  end
  
  def delete
    @user = User.find(params["user_to_delete"])
    if session["user_id"] == @user.id
      @user.delete
      redirect "/users"
    else
      "You can not delete this user. You must be signed in as this user."
    end
  end
  
  def login
  end
  
  def login_confirm
    user = User.find_by(email: params["email"])
    if BCrypt::Password.new(user.password) == params["password"]
      session["user_id"] = user.id
      redirect_to "/users"
    else
      erb :"/users/login"
    end
  end
end
