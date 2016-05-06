class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @user = User.find(params[:user_id])

    unless @user == current_user
      redirect_to user_tasks_path(current_user.id), alert: '不正な操作が行われました'
    end

    @tasks = Task.where(charge_id: current_user.id).where.not(done: true)
    @user = User.find(params[:user_id])
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new(user_id: params[:user_id], charge_id: params[:user_id])
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_task_path(@task.user, @task), notice: 'タスクが登録されました' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_task_path(@task.user, @task), notice: 'タスクが更新されました' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_path, notice: 'タスクを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status)
    end

    # 自分のタスク以外は見れないようにする
    def correct_user
      @user = User.find(params[:user_id])
      @task = Task.find(params[:id])

      if @user != current_user && @task.charge_id != current_user.id
        redirect_to user_tasks_path(current_user.id), alert: '他人のタスクのため、閲覧・操作権限がありません'
      end
    end
end
