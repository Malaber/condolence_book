Rails.application.routes.draw do
  get 'privacy/privacy'
  get 'impressum/impressum'
  get 'filler/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'filler#index'
end
