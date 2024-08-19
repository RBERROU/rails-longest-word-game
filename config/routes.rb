Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'

  # Root route (optional, redirect to the game)
  root 'games#new'
end
