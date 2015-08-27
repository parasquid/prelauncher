Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'refer-a-friend' => 'users#refer', as: "referrals"
  root to: 'users#new'
end
