Rails.application.routes.draw do

  devise_for :users
  resources :banners, only: [:index]
  resource :home, only: [:show]

  ############ SMS Routes ###################
  resources :sms_tokens, only: [:show]  do
    collection do
      post 'register'
    end
  end
  ###########################################

  ########### UserInfo Route ################
  resource :user_info, only: [:show, :update]
  ###########################################

  ########### Sport Route ################
  resources :sports, only: [:create, :show]
  ###########################################

end
