class PostsController < ApplicationController
  # skip_before_action :login_required, :only => [:index]

  def create
    @post = @user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Your have entered a new daily post"
      redirect_to timesheet_path(@user)
    else 
      flash.new[:error] = 'Creating a new daily post failed, Please check the error.'
      render 'posts/show'
    end
  end

end