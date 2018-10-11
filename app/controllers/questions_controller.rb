class QuestionsController < ApplicationController

  def index
    #In order from timestamps after creating
    @questions = Question.all.order(:created_at).reverse_order
  end

  def show
    #selecting which quesition from id
    @question = Question.find(params[:id])
    # answers within the question id
    @answers = @question.answers
    #.order(:created_at).reverse_order ,to put recent answer first
    #creating an answer
    @answer = Answer.new
  end

  #GET /questions/new
  def new
    @question = Question.new
  end

  #Get/question/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  #Post/Questions
  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = "You created a question."
      redirect_to @question
    else
      flash[:error] = "Title cannot be blank and less then 20 characters; Description cannot be blank and less then 50 characters."
      render :new
    end
  end

  # PATCH/PUT /Questions/1
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "Question is Updated."
      redirect_to question_path
      # or @question
    else
      flash[:error] = "description must be at lease 50 characters"
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    # @question.destroy
    redirect_to questions_path, notice: 'Question was successfully destroyed.'
    #or to index '/questions'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
