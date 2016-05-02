class Project::TasksController < TasksController
  # ベースはTasksControllerから継承して、リダイレクト処理のみこちらで制御
  skip_before_filter :correct_user # correct_userフィルターを除外
  before_action :set_project

  def show
  end

  def new
    @project_task = Task.new(user_id: current_user.id, charge_id: current_user.id, project_id: @project.id)
  end

  def create
    @project_task = @project.tasks.build(project_task_params)

    # 投稿を操作するユーザがログイン中のユーザか判定
    unless @project_task.user_id == current_user.id
      redirect_to @project, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @project_task.save
        format.html { redirect_to project_task_path(@project, @project_task.id), notice: 'プロジェクトのタスクを作成しました' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @project_task = @task
  end

  def update
    @project_task = @task

    # 投稿を操作するユーザがログイン中のユーザか判定
    unless @project_task.user_id == current_user.id
      redirect_to @project, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @project_task.update(project_task_params)
        format.html { redirect_to project_task_path(@project, @project_task), notice: 'タスクが更新されました' }
        format.json { render :show, status: :ok, location: @project_task }
      else
        format.html { render :edit }
        format.json { render json: @project_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def sub_destroy
    @project_task = Task.find(params[:id])

    @project_task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'タスクを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def project_task_params
      params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status)
    end

    def project_params
      params.require(:project).permit(:name, :content, :user_id, :customer_id)
    end
end
