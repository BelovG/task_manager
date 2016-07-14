Rails.application.routes.draw do
  scope :module => 'web' do
    root 'tasks#index'

    resources :tasks, only: [:index, :new, :create]

    resources :users, only: [] do
      scope :module => 'users' do
        resources :tasks, except: [:new, :create] do
          member do
            post :download_file
          end
        end
      end
    end

    resources :sessions, only: [:new, :create, :destroy]
    match '/sign_in',  to: 'sessions#new',         via: 'get'
    match '/sign_out', to: 'sessions#destroy',     via: 'delete'
  end
end
