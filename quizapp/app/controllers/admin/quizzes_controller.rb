class Admin::QuizzesController < Admin::AdminBaseController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  
  def index
    @quizzes = Quiz.all
  end

  
  def show
  end

  def new
    @quiz = Quiz.new
    @questions = Question.includes(:choices)
    @tests = @questions.count.times do
      @quiz.tests.build
    end
  end


  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to admin_quiz_path(id: @quiz.unique_code), notice: 'Quiz was successfully created.'
    else
      render action: 'new', alert: 'Quiz could not be saved'
    end
  end



  private

    def set_quiz
      @quiz = Quiz.includes(:questions).find_by(unique_code: params[:id])
      if @quiz.nil?
        flash[:alert] =  "Quiz you are looking for does not exist" 
        redirect_to_back_or_default_url 
      end
    end

    def quiz_params
      params.require(:quiz).permit(tests_attributes: [:id, :question_id, :_destroy, :quiz_id])
    end
end
