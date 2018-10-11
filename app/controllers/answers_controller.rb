class AnswersController < ApplicationController

  #Post/Answers
  def create
    #sending to db
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    #steps to make answers
      # {description: params[:answer][:description], question_id: params[:question_id]})
    @answer.question = @question
    # join answer.question_id == question_id, rails magic
    # (answer_params)
    if @answer.save
      flash[:notice] = "You answer the question!"
      redirect_to "/questions/#{params[:question_id]}"
    else
      flash[:error] = "Answer cannot be less then 50 characters."
      @answers = @question.answers
      render './questions/show'
      # redirect_to "/questions/#{params[:question_id]}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_params
      params.require(:answer).permit(:description)
    end
end
