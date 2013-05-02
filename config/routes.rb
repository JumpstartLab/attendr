Attendr::Application.routes.draw do
  root to: "events#new"

  resources :events
  resources :attendees

  resources :runtimes, only: [:create, :index]
end
