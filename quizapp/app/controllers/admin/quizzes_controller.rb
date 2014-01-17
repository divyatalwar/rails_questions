class Admin::QuizzesController < Admin::AdminBaseController
  before_action :set_quiz, only: [:show]

  
  def index
    @quizzes = Quiz.all
  end

  
  def show
  end

  def new
    @quiz = Quiz.new
    @questions = Question.all
    @tests = @questions.count.times do
      @quiz.tests.build
    end
  end


  def create
    @quiz = Quiz.new(quiz_params)
    respond_to do |format|
      if @quiz.save
        flash[:notice] = 'Quiz was successfully created.'
        format.js { render js: %(window.location.href='#{admin_quiz_path(id: @quiz.unique_code)}')}
      else
        format.js {render "shared/_error_messages", locals: { :target => @quiz } }
      end
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
