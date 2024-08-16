Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :employees do
    resources :attendances, only: [:index, :new, :create]
    resources :leaves, only: [:index, :new, :create, :update]
    resources :organizations, only: [:index, :new, :create]
    resources :work_from_homes, only: [:index, :new, :create, :update]
  end

end
