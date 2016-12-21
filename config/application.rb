require File.expand_path('../boot', __FILE__)

require 'rails/all'

#config.autoload_paths += %W(#{config.root}/lib)
#config.autoload_paths += Dir["#{config.root}/lib/**/"]

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module C2
  class Application < Rails::Application
	   
    config.middleware.use Rack::Affiliates
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
	  
	config.to_prepare do
#		Devise::SessionsController.layout "pages"
		Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "devise" }
#		Devise::ConfirmationsController.layout "pages"
#		Devise::UnlocksController.layout "pages"            
#		Devise::PasswordsController.layout "pages"        
	end
	  
#	config.middleware.insert_before 0, "Rack::Cors" do
#      allow do
#        origins '*'
#        resource '*', :headers => :any, :methods => [:get, :post, :options]
#      end
#    end
  end
end