class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.reverse_order
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = @question.answers.reverse_order
    @answer = @question.answers.build(user_id: current_user.id)
  end

  # GET /questions/new
  def new
    @question   = Question.new(user_id: current_user.id)
    @categories = Category.all
    @languages  = Language.all
  end

  # GET /questions/1/edit
  def edit
    @categories = Category.all
    @languages  = Language.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    # 投稿を操作するユーザがログイン中のユーザか判定
    if @question.user_id != current_user.id
      redirect_to questions_path, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: '質問を投稿しました' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question = Question.new(question_params)

    # 投稿を操作するユーザがログイン中のユーザか判定
    if @question.user_id != current_user.id
      redirect_to questions_path, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: '質問を編集しました' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    # 投稿を操作するユーザがログイン中のユーザか判定
    if @question.user_id != current_user.id
      redirect_to questions_path, alert: '不正な操作が行われました'
      return
    end

    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: '質問を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id, :category_id, :language_id, :title, :content)
    end
end
