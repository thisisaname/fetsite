
 Fetsite::Application.routes.draw do
  resources :fetmeetingtops


  resources :fetmeetings


  themes_for_rails
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :home, :only=>[:index] do
  end
  
  scope '(:locale)/admin' do
    resources :users, :only=>[]  do 
      collection do
        get :index
        post :all_update
      end
      member do
        get :fb_set_default_publish_page
      end
    end
    get 'users/:id/add_role/:role', :controller=>:users, :action=>:add_role, :as=>'user_add_role'
    get 'users/:id/do_confirm', :controller=>:users, :action=>:do_confirm, :as=>'user_do_confirm'
    get 'config',:controller=>:config,:action=>:index , :as => 'config'
  end
  devise_for :users , :controllers=>{:omniauth_callbacks=> "users/omniauth_callbacks"}

  scope '(:locale)' do 
    scope '(t/:theme)' do
      get "wiki/:name", action: :wiki, controller: :wikis
      resources :wikis 
    end
  end
  
  scope '(:locale)' do
    scope '(t/:theme)' do

      scope '(:ansicht)' do
        resources :studien, :only=>[:new,:edit,:update,:destroy,:show] do
          member do
            get :edit_lvas
          end
        end
      end
      
      resources :modulgruppen,:only =>[:create,:index] do
      end
      
      resources :studien,:except=>[:show,:new,:edit,:update,:destroy], :shallow=>true do 
        resources :modulgruppen, :path => "(:locale)/modulgruppen"
      end
      get 'verwalten/studien', :controller=>:studien, :action=>:verwalten, :as=>'studien_verwalten'

      resources :lecturers
      resources :semesters
      resources :moduls do
        member do
          get 'edit_lvas'
          post 'update_lvas'       
          get 'load_tiss'
          post 'show_tiss'
        end
        collection do
          get 'edit_bulk'
          get 'new_bulk'
          post 'update_bulk'
        end
        
      end
      resources :beispiele do #, :only=>[:show,:index,:create]
        member do
          get 'like'
          get 'dislike'
        end
      end
      resources :lvas  do 
        member do
          get 'beispiel_sammlung'
          get 'compare_tiss'
          get 'load_tiss'
        end
        resources :beispiele#, :only=>[:show,:index,:create]

      end 
      
      resources :fetzneditions
      resources :galleries do
        collection do
          get 'verwalten'
        end
        resources :fotos
      end
      
      resources :gremien do 
        collection do 
          get 'verwalten'
        end
      end
      resources :fetprofiles do
        collection do 
          get 'verwalten'
          get 'internlist'
        end
      end
      
      resources :fragen, :only =>[:new, :edit, :update, :destroy, :create]
      

        resources :neuigkeiten, :only => [:show]      
      resources :rubriken do
        collection do 
          get 'verwalten' , :action => :alle_verwalten
          get 'intern'
        end
        member do
          get 'verwalten'
          put 'addmoderator'
          get 'removemoderator'
        end

        resources :neuigkeiten, :except => [:index] do 
          member do
            get 'publish'
            get 'unpublish'
            get 'add_calentry'
            get 'rm_calentry'
            get 'create_link'
            get 'find_link'
            get 'publish_to_facebook'
            get 'mail_to_fet'
          end
        end
      end
      
      resources :home, :only=>[:index] do
        get :search, :on => :collection
        collection do
          get 'intern'
          get 'admin'   
          get 'dev'
          get 'startdev'
          get 'linksnotimplemented'
          get 'kontakt' 
        end
      end

      resources :themengruppen do
        get :verwalten 
        get :verwalten_all,:on=>:collection
        get :faqs, :on=>:collection
        post :sort_themen
        post :sort_themengruppen, :on=>:collection
        resources :themen, :only=>[:new, :show]
      end
      
      resources :themen do
        member do
          get :attachments
          get :fragen
          get :verwalten
        end
        resources :attachments
      end
            
      resources :calendars
      get 'verwalten/calendars', :controller=>:calendars, :action=>:verwalten, :as=>'calendars_verwalten'
      resources :calentries
    end
  end
  root :to => 'home#index'
end

