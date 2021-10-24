Rails.application.routes.draw do
  root to: 'games/rock_paper_scissors#new'

  namespace :games do
    resources :rock_paper_scissors
  end
end
