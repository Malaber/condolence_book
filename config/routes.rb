Rails.application.routes.draw do
  get 'book', to: 'book#get'
  get 'privacy', to: 'privacy#get'
  get 'impressum', to: 'impressum#get'
  get 'index', to: 'filler#get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'filler#get'
end
