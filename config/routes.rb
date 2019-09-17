Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'loaderio-1c493a70a663a13d0e37083f945c6a5b', to: 'filler#loader'
  get 'articles/list', to: 'articles#list'
  resources :articles do
    member do
      get :confirm_email
      get :publish_post
    end
  end
  get 'privacy', to: 'privacy#get'
  get 'impressum', to: 'impressum#get'
  get 'index', to: 'filler#get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'filler#get'
end
