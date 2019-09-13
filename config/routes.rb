Rails.application.routes.draw do
  get 'squire', to: 'squire#get'
  get 'editor', to: 'editor#get'
  get 'filler/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'filler#index'
end
