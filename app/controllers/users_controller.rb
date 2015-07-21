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
      redirect "/users/login"
    else
      render :"/users/new"
    end
  end
end
