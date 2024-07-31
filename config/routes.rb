Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :employees do
    resources :attendances
    resources :leaves
    resources :work_from_homes, controller: 'work_from_home'
  end

  # root to: 'home#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # get '/404', to: 'errors#not_found'
  # # Route for custom 500 page
  # get '/500', to: 'errors#internal_server_error'

  # Catch-all route for invalid paths
  # match '*path', to: 'errors#not_found', via: :all
end
