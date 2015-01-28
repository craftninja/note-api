Rails.application.routes.draw do
  root 'notes#api'
  resources :notes, except: [:new, :edit]
end
