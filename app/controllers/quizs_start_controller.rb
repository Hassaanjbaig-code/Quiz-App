class QuizsStartController < ApplicationController
  include QuizsStartHelper

  def new
  end

  def create
    quizs = quizs_params
    convertQuiz = QuizsStart.convert_Input quizs[:question]
    session[:quizs] = convertQuiz
    respond_to do | format |
      format.html { redirect_to root_path, notics: "Quiz is started" }
    end
  end

  private
  def quizs_params
    params.permit(:question)
  end
end
