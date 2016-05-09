class SubmitRequestsController < ApplicationController
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy]
  before_action :sub_set_submit_request, only: [:approve, :unapprove, :reject]

  def index
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def new
    ids = current_user.friend.map { |user| user.id }
    @users = User.where(id: ids)
    @tasks = Task.where.not(id: SubmitRequest.select(:task_id))
                 .where(user_id: current_user.id, done: false)
    @submit_request = current_user.submit_requests.build(status: 1)
    @user = @submit_request.user
  end

  def create
    @submit_request = SubmitRequest.new(submit_request_params)
    @notification = @submit_request.notifications.build(recipient_id: @submit_request.charge_id, sender_id: current_user.id, read: false)

    respond_to do |format|
      if @submit_request.save
        @submit_request.task.update(status: 0)
        format.html { redirect_to @submit_request, notice: '依頼を作成しました' }
      else
        format.html { rendeer :new }
      end
    end
  end

  def show
  end

  def edit
    ids = current_user.friend.map { |user| user.id }
    @users = User.where(id: ids)
    @tasks = Task.where(user_id: current_user.id, done: false)
                 .where.not(id: SubmitRequest.select(:task_id))
  end

  def update
    respond_to do |format|
      if @submit_request.update(submit_request_params)
        @submit_request.task.update(charge_id: submit_request_params[:charge_id])
        format.html { redirect_to @submit_request, notice: '依頼を更新しました' }
      else
        format.html { rendeer :edit }
      end
    end
  end

  def destroy
  end

  def approve
    @submit_request.update(status: 2)
    @submit_request.task.update(charge_id: current_user.id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).reverse_order

    respond_to do |format|
      format.js
    end
  end

  def unapprove
    @submit_request.update(status: 9, charge_id: @submit_request.user_id)
    @submit_request.task.update(charge_id: @submit_request.user_id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).reverse_order

    respond_to do |format|
      format.js
    end
  end

  def reject
    @submit_request.update(status: 8)
    @submit_request.task.update(charge_id: current_user.id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).reverse_order

    respond_to do |format|
      format.js
    end
  end

  def inbox
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).reverse_order
  end

  private

    def submit_request_params
      params.require(:submit_request).permit(:task_id, :user_id, :charge_id, :status, :message)
    end

    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

    def sub_set_submit_request
      @submit_request = SubmitRequest.find(params[:submit_request_id])
    end
end
