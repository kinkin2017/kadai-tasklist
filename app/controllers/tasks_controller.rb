class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end
  
  def show
    # @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
 #   @task_d = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に作成されました'
      redirect_to tasks_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Taskが作成されませんでした'
      render :index
    end
  end
  
  def edit
    # @task = Task.find(params[:id])
  end
  
  def update
    # @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    # @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskが正常に削除されました'
    redirect_back(fallback_location: tasks_path)
  end
  
  private
  def tasks_params
    params.require(:task).permit(:contet,status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to tasks_url
    end
  end
  
  def find_task
    #@task = Task.find(params[:id])
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:contet, :status)
  end

end
