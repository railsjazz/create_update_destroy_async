class HomeController < ApplicationController

  def index1
    @project = current_user.projects.first

    ProjectView.create(user: current_user)

    render json: @project
  end

  def index2
    @project =  current_user.projects.first

    ProjectView.create_async(user: current_user)

    render json: @project
  end

  private

  def current_user
    User.first
  end
end
