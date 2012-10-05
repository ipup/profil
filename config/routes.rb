NameUp::Application.routes.draw do
    # The priority is based upon order of creation:
    # first created -> highest priority.
    # IMPORTANT: The match :domain of FrontEnd should stay at the end of this file

    # CRUD resources:
    #
    # Default RESTful routes for objects stored in DB:
    # - Customizations
    # - Online CV Fields
    # - External Links
    # - User contents
    # - Invite codes
    #
    # The default action "index, show, edit" are not created (and shouldn't).
    resources :customizations,   :only => [:new, :create, :update, :destroy]  
    resources :online_cv_fields, :only => [:new, :create, :update, :destroy]  
    resources :external_links,   :only => [:new, :create, :update, :destroy]  
    resources :user_contents,    :only => [:new, :create, :update, :destroy]  
    resources :invite_codes,     :only => [:new, :create, :update, :destroy]
    
    
    # Routes for the contact form (object is named supports)
    resources :supports,         :only => [:new, :create]


    # BACKEND ROUTES:
    # Controller: "app/controllers/backend_controller.rb"
    # Every routes are configured for GET resource. PUT,POST or DESTROY shouldn't happen.
    #
    # Available routes:
    # - Account (default) : Basic User information
    # - Resume : CV File and Online Resume
    # - Privacy : Manage invites codes
    # - About : Manage user advanced description
    # - Custom : Manage theme and every CSS customizations
    # - Social : Manage social networks and external links
    get "backend",         :to => "backend#account"
    get "backend/account", :to => "backend#account"
    get "backend/resume",  :to => "backend#resume"
    get "backend/privacy", :to => "backend#privacy"
    get "backend/about",   :to => "backend#about"
    get "backend/custom" , :to => "backend#custom"
    get "backend/social" , :to => "backend#social"
    # - Callback d'authentification Twitter
    get "backend/social/twitter", :to => "backend#twitter"


    # HOME ROUTES:
    # Controller: "app/controllers/home_controller.rb"
    # Every routes are configured for GET resource. PUT,POST or DESTROY shouldn't happen.
    #
    # Available routes:
    # - Index (default and root) : Homepage
    # - noJS : Error page for user who doesn't have JAVASCRIPT enabled for BACKEND
    # - legal : Legal Mentions. Page where logged users can delete their account
    get "home/index"
    get "noJS",  :to => "home#noJSwarning"
    get "legal", :to => "home#legal"
 
    root :to => 'home#index'
    
    
    # DEVISE ROUTES:
    # Devise is a flexible authentication solution for Rails with Warden
    # Devise page: https://github.com/plataformatec/devise
    #
    # Some default controller are overridden for customized behaviors.
    # - Registrations controller: "app/controllers/registrations_controller.rb"
    # - Passwords controller: "app/controllers/passwords_controller.rb"
    # - Confirmations controller: "app/controllers/confirmations_controller.rb"
    #
    # Also, some routes are created for customized login/logout/register actions.
    # Those routes are not used but are reserved for the future... 
    devise_for :users, :controllers => { :registrations => "registrations",
                                         :passwords => "passwords",
                                         :confirmations => "confirmations" }
    devise_for :users do
      get "/login",    :to => "devise/sessions#new"      # Add a custom sign in route for user sign in
      get "/logout",   :to => "devise/sessions#destroy"  # Add a custom sing out route for user sign out
      get "/register", :to => "devise/registrations#new" # Add a Custom Route for Registrations
    end
   
   
    # FRONTEND ROUTES:
    # Controller: "app/controllers/frontend_controller.rb"
    # The main behaviour is to link a "root/domain/page" link to FrontEnd controller with domain as a variable
    #
    # Available routes:
    # - Home
    # - Online_resume
    # - About
    # - Contact
    # - Twitter
    # - Facebook
    # - LinkedIn
    #
    # Other routes (corresponding to some actions) :
    # - GET /notfound/ : our 404 page. Is called when domain matchs none.
    # - POST /checkcode/ : will create a session if the posted code is valid. Redirect to 'request referer'.
    # - POST /private_mode/ : Available to logged user on their page. Create session.  Mimic a valid invites codes.
    #                         Redirect to 'request referer'.
    # - POST /public_mode/ : Available to logged user on their page. Destroy session created by 'private_mode'.
    #                        Redirect to 'request referer'. 
    controller :frontend do
      get   "notfound"
      post  "checkcode",    :to => "frontend#checkcode"
      post  "public_mode",  :to => "frontend#public_mode"
      post  "private_mode", :to => "frontend#private_mode"
      match "/:domain"          => "frontend#home"
      match "/:domain/resume"   => "frontend#online_resume"
      match "/:domain/about"    => "frontend#about"
      match "/:domain/contact"  => "frontend#contact"
      match "/:domain/facebook" => "frontend#facebook"
      match "/:domain/twitter"  => "frontend#twitter"
      match "/:domain/linkedin" => "frontend#linkedin"
    end


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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
