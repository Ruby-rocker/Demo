Rails.application.routes.draw do

  resources :campaign_rules
  post 'remove_multiple_campaign_rule' => 'campaign_rules#remove_multiple_campaign_rule', as: :remove_multiple_campaign_rule

  get 'push_configurations' => 'push_configurations#index', as: :push_configurations
  post 'update_configuration' => 'push_configurations#update_configuration', as: :update_configuration

  resources :find_ways
  get 'find_a_way' => 'find_ways#find_a_way', as: :find_a_way
  post 'create_way' => 'find_ways#create_way', as: :create_way

  resources :contacts
  post 'remove_multiple_contact' => 'contacts#remove_multiple_contact', as: :remove_multiple_contact

  post 'send_push_notification' => 'contacts#send_push_notification', as: :send_push_notification, format: :json

  # Mobile APIs
  post 'attachment_url' => 'mobile_apis#attachment_url', as: :attachment_url, format: :json
  post 'get_beacons_and_campaigns' => 'mobile_apis#get_beacons_and_campaigns', as: :get_beacons_and_campaigns, format: :json
  post 'campaign_image' => 'mobile_apis#campaign_image', as: :campaign_image, format: :json

  resources :campaigns
  post 'remove_multiple_campaign' => 'campaigns#remove_multiple_campaign', as: :remove_multiple_campaign
  get 'audio' => 'campaigns#audio', as: :audio
  post 'create_audio' => 'campaigns#create_audio', as: :create_audio

  resources :beacon_ranges

  resources :ibeacons
  post 'remove_multiple_ibeacon' => 'ibeacons#remove_multiple_ibeacon', as: :remove_multiple_ibeacon

  get "/get_ibeacon_stores" => "ibeacons#get_stores", as: :get_ibeacon_stores
  get "/get_campaign_stores" => "campaigns#get_stores", as: :get_campaign_stores

  resources :stores
  resources :analytics

  resources :locations 
  post 'remove_multiple_location' => 'locations#remove_multiple_location', as: :remove_multiple_location

  resources :template_masters
  post 'remove_multiple_template' => 'template_masters#remove_multiple_template', as: :remove_multiple_template

  resources :categories

  resources :roles
  post 'remove_multiple' => 'roles#remove_multiple', as: :remove_multiple

  #post 'remove_multiple' => 'application#remove_multiple', as: :remove_multiple
  get 'comingsoon' => 'application#comingsoon', as: :comingsoon

  resources :access_modules

  post 'admin_roles' => 'roles#admin_roles', as: :admin_roles

  devise_for :admins
    devise_scope :admin do
      post 'remove_multiple_admin' => 'devise/registrations#remove_multiple', as: :remove_multiple_admin
  end

  #ajax routes
  get '/get_states' => 'application#get_states', as: :get_states
  get '/get_beacons' => 'campaign_rules#get_beacons', as: :get_beacons
  get '/get_campaigns' => 'campaign_rules#get_campaigns', as: :get_campaigns
  get '/get_rules' => 'campaign_rules#get_rules', as: :get_rules

  root to: "home#index"
end
