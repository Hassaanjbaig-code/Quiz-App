Rails.application.routes.draw do
  get "new_quiz", to: "quizs_start#new"
  post "quizs_create", to: "quizs_start#create"
  get "quizs/next_quiz", as: :next_quiz
  get "quizs/previous_quiz", as: :previous_quiz
  post "quizs/submit_quiz", as: :submit
  get "quizs/result_quiz", as: :result
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   root "quizs#index"
end
