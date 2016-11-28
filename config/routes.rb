Rails.application.routes.draw do

  root :to => redirect('main/index.html')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    scope '/v1' do
      # need to create signup email,f_name,l_name,password

      #public
      post 'login'=> 'authentication#authenticate'

      delete 'logoff'=> 'authentication#unauthenticate'
      post 'signup' => 'users#create'
      put 'change_password'=> 'users#update'
      put 'update_email'=> 'users#update'
      get 'users' => 'users#index'
      resources :bookings

      resources :notes

      post 'categories/new'

      #public
      get 'categories' => 'categories#index'

      get 'courses/enrolled'
      get 'courses/created'
      post 'courses/new'

      # public
      get 'courses/popular'
      get 'course/:id' => 'courses#show'
      get 'courses' => 'courses#index'

      # public
      get 'activities/upcoming'
      get 'activity/:id' => 'activities#show'
      get 'activities' => 'activities#index'


      get 'activities/enrolled'
      get 'activities/created'
      post 'activities/new'

      put 'requests/access/:type' => 'accessrequests#update'

      get 'requests/access/pending' => 'accessrequests#pending'
      get 'requests/access/approved' => 'accessrequests#approved'
      get 'requests/access/rejected' => 'accessrequests#rejected'

      get 'requests/access/admin' => 'accessrequests#admin_requests'
      get 'requests/access/super_user' => 'accessrequests#super_user_requests'
    end

  end
end
