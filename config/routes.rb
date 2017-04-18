Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create]
end
