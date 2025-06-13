Rails.application.routes.draw do
  resources :ministers, only: [ :index, :show ]
  resources :departments, only: [ :index, :show ]
  resources :promises, only: [ :index, :show ]
  resources :evidences, only: [ :index, :show ]

  # GoodJob dashboard
  unless Rails.env.development?
    GoodJob::Engine.middleware.use Rack::Auth::Basic do |username, password|
      username == ENV["ADMIN_LOGIN"] && password == ENV["ADMIN_PASSWORD"]
    end
  else
  end
  mount GoodJob::Engine => "/admin/good_job"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
