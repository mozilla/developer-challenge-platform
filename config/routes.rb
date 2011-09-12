Mozchallenge::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  
  match '/auth/github/callback' => 'profiles#github'
  match '/auth/twitter/callback' => 'profiles#twitter'
  
  resource :community, :controller => :community
  
  resources :users do
    resource :profile, :controller => :profiles, :as => :profiles
  end
  
  resources :challenges do
    resources :attempts do
      resources :reviews
      resources :judgings
    end
  end
  
  resource :session, :controller => :sessions do
    collection do
      post :browser_id
    end
  end
  
  resources :messages
  
  namespace :admin do
    root :to => 'challenges#index'
    resource :community, :controller => :community
    resources :challenges do
      member do
        post :activate
        post :review
        post :judge
        post :feature
        post :complete
        post :assign_reviewers
        post :assign_judges
      end
    end
    resources :users
  end
  
  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
