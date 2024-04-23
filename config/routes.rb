Rails.application.routes.draw do
  get '/', to: 'games#new'
  get 'games/', to: 'games#index'
  root to: 'games#new'

  namespace :games do
    resources :rock_paper_scissors
    resources :tic_tac_toe
  end
end
