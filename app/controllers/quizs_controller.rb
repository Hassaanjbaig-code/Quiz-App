class QuizsController < ApplicationController

 before_action :quiz_options
  attr_accessor :answers

  def index
    @quiz = @quizs[@start_quiz]
    @complete_quiz_percentage = progress_width(@start_quiz, @total_quiz - 1)
  end

  def next_quiz
      session[:start_quiz] = @start_quiz + 1 if @start_quiz <= @total_quiz
      @start_quiz = session[:start_quiz]
      @quiz = @quizs[@start_quiz]
      @complete_quiz_percentage = progress_width(@start_quiz, @total_quiz - 1)
      respond_to do | format |
        format.html { redirect_to root_path, notics: "Next Quiz" }
        format.turbo_stream
      end
  end

  def previous_quiz
    session[:start_quiz] = @start_quiz - 1 if @start_quiz > 0
    @start_quiz = session[:start_quiz]
    @quiz = @quizs[@start_quiz]
    session[:answers] = @answers
    @answers.pop()
    if @answers.length == 1
      @answers = []
    end
    @answers = session[:answers]
    @complete_quiz_percentage = progress_width(@start_quiz, @total_quiz - 1)
    respond_to do | format |
      format.html { redirect_to root_path, notics: "Previous Quiz" }
      format.turbo_stream { render :next_quiz }
    end
  end

  def submit_quiz
   @answers << quizs_params[:answer] # get the actual answer string
    session[:answers] = @answers
    respond_to do | format |
      if @answers.include?(quizs_params[:answer])
        format.json { render json: { status: 200, message: "Accepted" }, status: 200 }
      end
    end
  end

  def result_quiz
    session[:answers] = @answers
    marks_calculate = 0
    @incorrect_quiz = 0
    i = 0
    puts @answers.length
    while i < @answers.length
      if @answers[i] == @quizs[i]["correctAnswer"]
        marks_calculate +=1
      else
        @incorrect_quiz+=1
      end
      i+=1
    end
    @final_result = zero_if_negative(marks_calculate)
    @incorrect_quiz = zero_if_negative(@incorrect_quiz)
    @score_percentage = progress_width(@final_result,@total_quiz).to_i
    session[:start_quiz] = 0
    session[:answers] = []
    respond_to do | format |
      format.html
    end
  end

  private

  def progress_width(current_quiz, total_quiz)
    percentage = (current_quiz.to_f / total_quiz.to_f) * 100
    clamped_percentage = [[percentage, 0].max, 100].min
    clamped_percentage
  end

  def quizs_params
    params.require(:quizs).permit(:answer)
  end

  def zero_if_negative(num)
    [ num.abs, 0 ].max
  end

  def quiz_options
    @quizs = session[:quizs]
    @total_quiz = @quizs.count
    @start_quiz = session[:start_quiz] || 0
    @answers = session[:answers] || []
    @complete_quiz_percentage = 0
  end
end
