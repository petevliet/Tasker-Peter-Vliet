Rails.application.routes.draw do
  resources :users, :tasks, :projects

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'about' => 'about#index'
  get 'faq' => 'common_questions#index'
  get 'terms' => 'terms#index'
  get 'tasks' => 'tasks#index'
  get 'users' => 'users#index'
  get 'projects' => 'projects#index'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

end
