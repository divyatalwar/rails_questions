Tweets::Application.routes.draw do
 
resources :users do
  get 'timeline', on: :member
  get 'followers',  on: :member
  get 'followees',  on: :member
  # get 'tag_list',on: :collection

end
post 'change_privacy', to: 'users#change_privacy'
post 'retweet' ,to: 'posts#retweet'
get 'auto-complete', to: 'users#autocomplete_suggestions', as: :autocomplete

devise_for :user, controllers: {
  omniauth_callbacks: "omni_auth/omniauth_callbacks", 
  registrations: "omni_auth/registrations",
  sessions: "omni_auth/sessions"
}
#FIXME_AB: Do we  have all actions for these routes?
#fixed
resources :followings, only:[ :create, :destroy]
resources :posts, only: [:create, :index, :edit] do
  get 'hash_tags', on: :collection
  get 'user_tags', on: :collection
end
root 'posts#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
