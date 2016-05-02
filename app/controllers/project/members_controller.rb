class Project::MembersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @users = User.all
  end

  def create
    @project = Project.find(params[:project_id])
    @member = @project.members.build(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to project_members_path(@project), notice: 'プロジェクトメンバーに追加しました' }
      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @member = Member.find(params[:id])
    @member.destroy
    respond_to do |format|
      format.html { redirect_to project_members_path(@project), notice: 'プロジェクトメンバーから外しました' }
    end
  end

  private

    def member_params
      params.require(:member).permit(:user_id, :project_id)
    end
end
