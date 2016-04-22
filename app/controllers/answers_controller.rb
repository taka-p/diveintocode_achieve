class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    @question = @answer.question
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @question = @answer.question

    # 投稿を操作するユーザがログイン中のユーザか判定(alertはajaxで制御)
    if @answer.user_id != current_user.id
      return render 'answers/show.js.erb', params: 'error'
    end

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
        format.js { render :show, notice: '回答を投稿しました' }

        # 回答が投稿されたら、質問者にメールを送る
        if @question.user.provider.empty?
          logger.debug "メール送るよ #{@question.user.provider}"
          @inquiry = Inquiry.new(name: @answer.user.name, email: @question.user.email, message: @answer.content)
          InquiryMailer.send_notice_answer_email(@inquiry).deliver
        end
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    @answer = Answer.new(@answer_params)

    # 投稿を操作するユーザがログイン中のユーザか判定
    if @answer.user_id != current_user.id
      redirect_to questions_path, alert: '不正な操作が行われました'
      return
    end

    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: '回答を編集しました' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @question = @answer.question

    # 投稿を操作するユーザがログイン中のユーザか判定
    if @answer.user_id != current_user.id
      return render 'answers/show.js.erb', params: 'error'
    end

    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :show, notice: '回答を削除しました' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:question_id, :user_id, :content)
    end
end
