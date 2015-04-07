Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :users

  resources :projects do
    resources :memberships
    resources :tasks do
      resources :comments
    end
  end

  get 'about' => 'about#index'
  get 'faq' => 'common_questions#index'
  get 'terms' => 'terms#index'
  get 'users' => 'users#index'
  get 'projects' => 'projects#index'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  get '/signup' => 'registrations#new'
  post '/signup' => 'registrations#create'

end
