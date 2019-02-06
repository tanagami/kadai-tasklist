class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.task.build
      @tasks = current_user.task.order('created_at DESC')
    end
  end
end
