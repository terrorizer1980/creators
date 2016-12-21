Rails.application.routes.draw do

  resources :article_collections
  devise_for :users, controllers: { registrations: 'registrations' }
#  devise_scope :user do
#  end
  
  resources :profiles
  
  resources :channels, shallow: true do
      resources :presets
      resources :reviews
      resources :videos
      get 'videos/ytimport'
  end
  resources :channel_categories
  
  ## Subscriptions & Purchasing
  #post 'ppipns', to: 'ppipns#create'
  post 'admin/ppipn', to: 'ppipns#create'
  get 'admin/ppipn', to: 'ppipns#index'
    
  resources :subscriptions
    get 'paypal/checkout', to: 'subscriptions#paypal_checkout'	
    get 'paypal/cancellation', to: 'subscriptions#paypal_cancel'
  
  resources :txes
  resources :orders, shallow: true, only: [:index, :show, :update] do
    post 'purchase_items', on: :member
    put 'clear_gift_voucher', on: :member
  end
  get 'orders/basket', to: 'orders#show_wishlist'
  
  resources :gift_vouchers, shallow: true, only: [:index, :show, :update] do
  end
  
  ## Referrals
  
  resources :referrals do
    put 'increment_status', on: :member
    put 'decrement_status', on: :member
  end
  
  ## Galleries
  ## Special routes for uploading images and generating drop-downs by gallery_type
  ## In this case, the gallery_type param is required to extrapolate the gallery
  ## Combining the above and the currently selected channel, we can create or list
  ## gallery_images
  #  resources :gallery_images, path: '/custom', only: [:create, :index]
  get '/custom/gallery_images', to: 'gallery_images#index'
  get '/custom/render_gallery_dropdown', to: 'user_galleries#render_gallery_dropdown'
  resources :user_galleries, path: '/custom/user_galleries', shallow: true do
    get 'render_gallery_dropdown', on: :member
    resources :gallery_images
  end 
  
  ## Global resources & info
  resources :plans # for subscriptions
  resources :products # for orders
  resources :articles
  resources :news
  
  # Purchasables (products that can be bought with credits)
  
  resources :motion_graphics, path: '/custom/motion_graphics' do
    resources :order_items do
      get 'add_to_basket', on: :member
      get 'add_to_wishlist', on: :member
    end
    get 'get_custom_fields', on: :member
  end
  resources :motion_graphic_collections, path: '/custom/motion_graphic_collections'
  
  resources :songs, path: '/custom/songs' do
    resources :order_items do
      get 'add_to_basket', on: :member
      get 'add_to_wishlist', on: :member
    end
    get 'get_custom_fields', on: :member
  end
  
  ## Views
  
  get  'pages', to: 'pages#index'
  get  'pages/recruiter_tos'
  #get  'pages/home'
  #get  'pages/manifesto'
  
  get  'free_blogs',  to: 'pages#free_blogs'
  get  'manifesto',   to: 'pages#manifesto'
  get  'index',       to: 'pages#home'
  get  'home',        to: 'pages#home'
  
  get  'dashboard', to: 'dashboard#index'
  get  'dashboard_news', to: 'dashboard#news'
  get  'dashboard_articles', to: 'dashboard#articles'
  get  'dashboard/cancellation'
  get  'dashboard/reviews'
  get  'dashboard/subscribe'
  get  'dashboard/finish_onboarding'
  
  ## Admin-only routes
  namespace :admin do
    get '/', to: 'admin#index'
    resources :users, except: [:new, :create]
    resources :orders, except: [:new, :create] do
      put 'increment_status', on: :member
      put 'decrement_status', on: :member
    end
  end
  
  ## Apps
  
  get 'apps', to: 'apps#index'

  get 'apps/collaboration'
      get 'apps/collab_init_channel'
      get 'apps/collab_activate_channel'
      get 'apps/collab_disable_channel'
      get 'apps/collaboration/matches', to: 'apps#collab_matches'

  get  'apps/thumbnail'
      get  'apps/get_thumbnail_preset_list'
      get  'apps/get_thumbnail_preset'
      post 'apps/thumbnail_preset_save'
      get  'apps/thumbnail_preset_delete'

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  
  get '/forum' => redirect('http://forum.101.net')
  get '/twitter' => redirect('https://twitter.com/network_101')
  get '/templates' => redirect('/custom/motion_graphics')
  get '/join' => redirect('users/sign_up')
  get '/facebook' => redirect('https://www.facebook.com/network101MCN')

  root 'pages#home'
end