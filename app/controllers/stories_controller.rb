class StoriesController < ApplicationController
  def list
    @user = User.find(params["id"])
    @stories = User.find(params["id"]).stories
    render :"/stories/index"
  end
  
  def new
    
  end
end
