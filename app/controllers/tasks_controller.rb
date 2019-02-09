class TasksController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destory]
  
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.task.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.task.order('created_at DESC')
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render 'toppages/index'
    end
  end

  def edit
   @task = current_user.task.find_by(id: params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # def set_task
  #   @task = Task.find(params[:id])
  # end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.task.find_by(id: params[:id])
    unless @task
    redirect_to root_url
    end
  end
end

