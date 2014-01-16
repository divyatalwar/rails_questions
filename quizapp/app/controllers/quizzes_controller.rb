class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :result, :edit, :update, :destroy]
  before_action :get_questions, only: [:show]
  before_action :create_answer_instance, only: [:show]
  before_action :check_quiz_status, only:[ :show]

 

  def index
    @quizzes = Quiz.includes(:results, :users)
  end

  def show
  end

  def result
    @result = current_user.calculate_score(@quiz.id)
  end 
  


  private

    def get_questions
      @questions = @quiz.questions.page(params[:page]).per(1)
    end

    def create_answer_instance
      @user_answer = UserAnswer.new
    end

    def check_quiz_status
      if @quiz.has_already_been_taken?(current_user)
        flash[:alert] = "the quiz has already been taken by you."
        redirect_to_back_or_default_url
      end
    end

   
    def set_quiz
      @quiz = Quiz.find_by(unique_code: params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(tests_attributes: [:id, :question_id, :_destroy, :quiz_id])
    end
end
