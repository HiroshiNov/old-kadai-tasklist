class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show,:edit,:update,:destroy]

    def index
        @tasks = current_user.tasks
    end

    def show
      @task = current_user.tasks.find(params[:id])
    end

    def new
      @task = current_user.tasks.build
    end

    def create
      @task = current_user.tasks.build(task_params)

      if @task.save
        flash[:success] = "タスクが正常に登録されました"
        redirect_to @task
      else
        flash.now[:danger] = 'タスクが登録できませんでした'
        render :new
      end
    end

    def edit
      @task = current_user.tasks.find(params[:id])
    end

    def update
      # binding.pry
      @task = current_user.tasks.find(params[:id])

      if @task.update(task_params)
        flash[:success] = "タスクは正常に更新されました"
        redirect_to @task
      else
        flash.now[:danger] = 'タスクは更新できませんでした'
        render :edit
      end
    end

    def destroy
      @task = current_user.tasks.find(params[:id])
      @task.destroy

      flash[:success] = 'タスクは正常に削除されました'
      redirect_to tasks_url
    end


    private
    #Strong Parameters
    def task_params
      params.require(:task).permit(:content,:status)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    end
end
