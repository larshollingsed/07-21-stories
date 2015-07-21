class UsersController < ApplicationController
  def list
    self.log_user_in 
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
      redirect_to "/users"
    else
      @error = "You can not delete this user. You must be signed in as this user."
      redirect_to "/users"
    end
  end
  
  def edit
    if session["user_id"]
      if session["user_id"] == params["user_to_edit"].to_i
        @user = User.find(params["user_to_edit"])
        render :"/users/edit"
      else
        @error = "You're not logged in as the correct user"
        redirect_to "/users"
      end
    else
      @error = "You're not logged in"
      redirect_to "/users"
    end
  end
  
  def edit_confirm
    @user = User.find(params["user_to_edit"])
    @user.name = params["user"]["name"]
    @user.email = params["user"]["email"]
    if params["user"]["password"] != ""
      prepassword = params["user"]["password"]
      password = BCrypt::Password.create(prepassword)
      @user.password = password
    end
    @user.save
    redirect_to "/users"
  end
  
  # Works without users#login leads to views/users/login.html
  # def login
  # end
  
  def login_confirm
    user = User.find_by(email: params["email"])
    if BCrypt::Password.new(user.password) == params["password"]
      session["user_id"] = user.id
      redirect_to "/users"
    else
      erb :"/users/login"
    end
  end
  
  def logout
    session["user_id"] = nil
    redirect_to "/users"
  end
end
