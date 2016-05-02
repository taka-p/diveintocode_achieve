class Project::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @members = @project.members
    @tasks   = @project.tasks
  end

  def new
    @project = Project.new(user_id: current_user.id)
    @customers = Customer.all
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'プロジェクトを作成しました' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @customers = Customer.all
  end

  def update
    # 投稿を操作するユーザがログイン中のユーザか判定
    tmp = params.require(:project).permit(:user_id)
    @user = User.find(tmp["user_id"])
    if @project.user_id != current_user.id || @user.id != current_user.id
      redirect_to projects_path, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'プロジェクトを編集しました' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # 投稿を操作するユーザがログイン中のユーザか判定
    if @project.user_id != current_user.id
      redirect_to projects_path, alert: '不正な操作が行われました'
      return
    end

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'プロジェクトを削除しました' }
      format.json { head :no_content }
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :content, :user_id, :customer_id)
  end
end
