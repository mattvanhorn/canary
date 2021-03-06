Canary::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure',            to: 'sessions#failure'

  match '/sign-up',  to: 'registrations#new', :as => :sign_up
  match '/sign-in',  to: 'sessions#new',      :as => :sign_in
  match '/sign-out', to: 'sessions#destroy',  :as => :sign_out

  match '/about', to: 'pages#about', :as => :about

  match '/invitations/accept/:token', to: 'registrations#new', :as => :accept_invitation

  resources :projects, :only => [:index, :show, :new, :create] do
    resources :invitations, :only => [:new, :create, :show]
    resources :mood_updates, :only => [:new, :create, :index]
    get 'mine', :on => :collection, :as => :my
    get :autocomplete_company_name, :on => :collection
  end

  resources :companies, :only => [:index] do
    resources :projects,:only => [:index]
  end
  resources :project_links,:only => [:create]

  match '/vanity(/:action(/:id(.:format)))', :controller=>:vanity

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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
#== Route Map
# Generated on 30 Dec 2011 13:52
#
#                       auth_failure      /auth/failure(.:format)                          {:controller=>"sessions", :action=>"failure"}
#                            sign_up      /sign-up(.:format)                               {:controller=>"registrations", :action=>"new"}
#                            sign_in      /sign-in(.:format)                               {:controller=>"sessions", :action=>"new"}
#                           sign_out      /sign-out(.:format)                              {:controller=>"sessions", :action=>"destroy"}
#                  accept_invitation      /invitations/accept/:token(.:format)             {:controller=>"registrations", :action=>"new"}
#                project_invitations POST /projects/:project_id/invitations(.:format)      {:action=>"create", :controller=>"invitations"}
#             new_project_invitation GET  /projects/:project_id/invitations/new(.:format)  {:action=>"new", :controller=>"invitations"}
#                 project_invitation GET  /projects/:project_id/invitations/:id(.:format)  {:action=>"show", :controller=>"invitations"}
#               project_mood_updates GET  /projects/:project_id/mood_updates(.:format)     {:action=>"index", :controller=>"mood_updates"}
#                                    POST /projects/:project_id/mood_updates(.:format)     {:action=>"create", :controller=>"mood_updates"}
#            new_project_mood_update GET  /projects/:project_id/mood_updates/new(.:format) {:action=>"new", :controller=>"mood_updates"}
#                        my_projects GET  /projects/mine(.:format)                         {:action=>"mine", :controller=>"projects"}
# autocomplete_company_name_projects GET  /projects/autocomplete_company_name(.:format)    {:action=>"autocomplete_company_name", :controller=>"projects"}
#                           projects GET  /projects(.:format)                              {:action=>"index", :controller=>"projects"}
#                                    POST /projects(.:format)                              {:action=>"create", :controller=>"projects"}
#                        new_project GET  /projects/new(.:format)                          {:action=>"new", :controller=>"projects"}
#                            project GET  /projects/:id(.:format)                          {:action=>"show", :controller=>"projects"}
#                   company_projects GET  /companies/:company_id/projects(.:format)        {:action=>"index", :controller=>"projects"}
#                          companies GET  /companies(.:format)                             {:action=>"index", :controller=>"companies"}
#                                         /vanity(/:action(/:id(.:format)))                {:controller=>"vanity"}
#                               root      /                                                {:controller=>"homepage", :action=>"index"}
