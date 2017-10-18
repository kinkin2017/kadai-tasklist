class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end
  
  def show
    # @task = Task.find(params[:id])
  end
  
  def new
    @task_d = Task.new
  end
  
  def create
    @task_d = Task.new(task_params)
    
    if @task_d.save
      flash[:success] = 'Taskが正常に作成されました'
      redirect_to @task_d
    else
      flash.now[:danger] = 'Taskが作成されませんでした'
      render :new
    end
  end
  
  def edit
    # @task = Task.find(params[:id])
  end
  
  def update
    # @task = Task.find(params[:id])
    
    if @task_d.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task_d
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    # @task = Task.find(params[:id])
    @task_d.destroy
    
    flash[:success] = 'Taskが正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def find_task
    @task_d = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:contet, :status)
  end

end
