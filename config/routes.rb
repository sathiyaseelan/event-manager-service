Rails.application.routes.draw do

  root :to => redirect('main/index.html')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    scope '/v1' do
      post 'login'=> 'authentication#authenticate'
      delete 'logoff'=> 'authentication#unauthenticate'
      post 'change_password'=> 'users#update'
      post 'update_email'=> 'users#update'
      get 'users' => 'users#index'
      resources :bookings

      resources :notes

      post 'categories/new'
      get 'categories' => 'categories#index'

      get 'courses/popular'
      get 'courses/enrolled_courses'
      get 'courses/created_courses'
      get 'course/:id' => 'courses#show'
      post 'courses/new'
      get 'courses' => 'courses#index'

      get 'activities/upcoming'
      get 'activities/enrolled_activities'
      get 'activities/created_activities'
      get 'activity/:id' => 'activities#show'
      post 'activities/new'
      get 'activities' => 'activities#index'
    end
  end
end
