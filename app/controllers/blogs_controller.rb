# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class BlogsController < ApplicationController
  # ログイン判定
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.reverse_order
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    # 投稿を操作するユーザがログイン中のユーザか判定
    # if @blog.user_id != current_user.id
    #   redirect_to blogs_path, alert: '不正な操作が行われました'
    #   return
    # end

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: '記事を投稿しました' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    # TODO: データベースorモデルで弾く..._:(´ཀ`」 ∠):_
    # 投稿を操作するユーザがログイン中のユーザか判定
    tmp = params.require(:blog).permit(:user_id)
    @user = User.find(tmp["user_id"])
    if @blog.user_id != current_user.id || @user.id != current_user.id
      redirect_to blogs_path, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    # 投稿を操作するユーザがログイン中のユーザか判定
    if @blog.user_id != current_user.id
      redirect_to blogs_path, alert: '不正な操作が行われました'
      return
    end

    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :user_id)
    end
end
