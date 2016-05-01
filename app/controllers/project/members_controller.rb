class Project::MembersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.js { render :index, notice: 'プロジェクトメンバーに追加しました' }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.js { render :index, notice: 'プロジェクトメンバーから外しました' }
    end
  end

  private
  def member_params
    params.require(:member).permit(:user_id, :project_id)
  end
end
