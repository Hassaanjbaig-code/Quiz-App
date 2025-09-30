Rails.application.routes.draw do
  get "quizs/next_quiz", as: :next_quiz
  get "quizs/previous_quiz", as: :previous_quiz
  post "quizs/submit_quiz", as: :submit
  get "quizs/result_quiz", as: :result
  get "quizs/show", as: :start
  resource :quizs, only: [ :create ]
  get "up" => "rails/health#show", as: :rails_health_check

   root "quizs#index"
end
