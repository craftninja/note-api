Rails.application.routes.draw do
  resources :notes, except: [:new, :edit]
end
