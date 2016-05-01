class Project::CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:edit, :update]

  def index
    @customers = Customer.all
    @customer  = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.js { render :index, notice: '顧客を追加しました' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @@customer.update(@customer_params)
        format.html { redirect_to @@customer, notice: '顧客情報を編集しました' }
        format.json { render :show, status: :ok, location: @@customer }
      else
        format.html { render :edit }
        format.json { render json: @@customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # プロジェクトから参照されるため、削除機能はつけない
  def destroy
  end

  private
  def set_customer
    @customer = Blog.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name)
  end
end
