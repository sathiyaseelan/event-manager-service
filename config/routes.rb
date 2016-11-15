Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    scope '/v1' do
      post 'login'=> 'authentication#authenticate'
      delete 'logoff'=> 'authentication#unauthenticate'
      post 'change_password'=> 'users#update'
      post 'update_email'=> 'users#update'
      get 'users' => 'users#index'
      resources :bookings
      resources :courses
      resources :notes
      resources :activities
    end
  end
end
