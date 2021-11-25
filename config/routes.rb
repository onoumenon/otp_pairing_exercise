Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post 'otp', to: 'otp#create'
    get 'otp/verify', to: 'otp#verify'
  end
end
