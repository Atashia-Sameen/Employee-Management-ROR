Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :employees do
    resources :attendances
    resources :leaves
    resources :organizations
    resources :work_from_homes, controller: 'work_from_home'
  end

end
