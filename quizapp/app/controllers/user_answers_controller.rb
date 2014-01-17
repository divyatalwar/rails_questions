class UserAnswersController < ApplicationController
  before_action :set_quiz, only: [:create]
  before_action :set_choice, only: [:create]

  
  def create
    @user_answer = current_user.user_answers.build(user_answers_params)
    if @user_answer.save
      flash[:notice] = "Answer recorded successfully"
    else
      flash[:alert] = "Answer could not be saved  because " + @user_answer.errors.full_messages.join(" ,")
    end
    redirect_to_next_or_result
  end



  private

  def redirect_to_next_or_result
    if (params[:page].to_i == (@quiz.questions.length))
      redirect_to result_path(id: @quiz.unique_code)
    else
      redirect_to quiz_path(id: @quiz.unique_code, :page => params[:page].to_i + 1)
    end

  end

  def set_quiz
    @quiz = Quiz.find_by(unique_code: params[:unique_code])
    redirect_to_back_or_default_url if @quiz.nil?
  end

  def set_choice
    params[:user_answer][:choice_id] = params[:user_answer][:choice].keys[0] if params[:user_answer][:choice]
  end

  def user_answers_params
    params.require(:user_answer).permit(:choice_id, :quiz_id,:question_id)
  end
end