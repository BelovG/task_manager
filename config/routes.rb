Rails.application.routes.draw do
  scope :module => 'web' do
    root 'tasks#index'

    resources :tasks do
      member do
        post :download_file
      end
    end

    resources :users, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resource :profile, only: :show
    end
    resources :sessions, only: [:new, :create, :destroy]
    match '/sign_in',  to: 'sessions#new',         via: 'get'
    match '/sign_out', to: 'sessions#destroy',     via: 'delete'
  end
end
