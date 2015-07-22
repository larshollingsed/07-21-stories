class StoriesController < ApplicationController
  def index
    @user = User.find(params["id"])
    @stories = User.find(params["id"]).stories
    render :"/stories/index"
  end
  
  def new
    if session["user_id"]
      if session["user_id"] == params["user_to_add_story_to"].to_i
        @user = User.find(session["user_id"])
        render :"/stories/new"
      else
        @error = "You're not logged in as the correct user"
        redirect_to "/users"
      end
    else
      @error = "You're not logged in"
      redirect_to "/users"
    end
  end
  
  def create
    @story = Story.create(:name => params["story"]["name"], :content => params["story"]["content"])
    @user = User.find(params["user_id"])
    @user.stories << @story
    redirect_to "/users"
  end
  
  def edit
    if session["user_id"]
      if session["user_id"] == params["user_to_edit_story_of"].to_i
        @user = User.find(session["user_id"])
        @story = Story.find(params["story_id"])
        render :"/stories/edit"
      else
        @error = "You're not logged in as the correct user"
        redirect_to "/users"
      end
    else
      @error = "You're not logged in"
      redirect_to "/users"
    end
  end
  
  def update
    @story = Story.find(params["story_id"])
    @story.name = params["story"]["name"]
    @story.content = params["story"]["content"]
    @story.save
    redirect_to "/users"
  end
end
