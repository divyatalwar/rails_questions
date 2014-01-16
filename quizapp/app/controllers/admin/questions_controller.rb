class Admin::QuestionsController < Admin::AdminBaseController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

 
  def index
    if params[:question_type]
      @questions = Question.includes(:choices).by_type(params[:question_type])
    else
      @questions = Question.includes(:choices)
    end
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = 'Question was successfully created.'
      redirect_to admin_question_path(@question)
    else
      render action: 'new' 
    end
  end


  private
    def set_question
      @question = Question.find(params[:id])
      if @question.nil?
        flash[:alert] = "Question could not be found"
        redirect_to_back_or_default_url
      end
    end

    def question_params
      params.require(:question).permit(:question_type, :description, choices_attributes: [:content, :id, :correct])
    end
end
