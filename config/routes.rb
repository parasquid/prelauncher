Rails.application.routes.draw do
  resources :users
  get 'refer-a-friend' => 'users#refer', as: "referrals"

end
