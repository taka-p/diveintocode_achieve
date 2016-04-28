class Taskline::TasksController < ApplicationController
  def ungoodjob
  end

  def goodjob
    # 該当タスクに自分がgoodjobした件数をカウント
    gdcount = Goodjob.where(task_id: goodjob_params[:task_id], user_id: current_user.id).count

    if gdcount == 0
      # goodjobしていなければ新規登録
      @gdj = Goodjob.create(user_id: current_user.id, task_id: goodjob_params[:task_id], number: 1)
    else
      # goodjobしている場合はカウントアップして追加登録
      @gdj = Goodjob.find_by(user_id: current_user.id, task_id: goodjob_params[:task_id])
      @gdj.number += 1
      @gdj.update(user_id: current_user.id)
    end

    @gdj_all_cnt = Goodjob.where(task_id: goodjob_params[:task_id]).sum(:number)

    # JSで描画
    respond_to do |format|
      format.js
    end
  end

  def index
    # 自分とフォローユーザのタスクを取得
    @feed_tasks = current_user.taskfeed
    # コメントモデルオブジェクト
    @taskline_task_comment = TaskComment.new
    # Goodjobモデルオブジェクト
    @goodjob = Goodjob.new
  end

  def create
  end

  def new
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :user_id, :charge_id, :deadline, :done, :status)
  end

  def task_comment_params
    params.require(:comment).permit(:user_id, :task_id, :content)
  end

  def goodjob_params
    params.require(:goodjob).permit(:user_id, :task_id, :number)
  end
end
