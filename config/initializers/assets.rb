# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

Rails.application.config.assets.precompile += 
%w( devise.css apps.css apps.js pages.css pages.js profiles.css thumbnail.css thumbnail.js purchasable_customize.css purchasable_customize.js)

# Rails.application.config.assets.precompile += %w( pages.css profiles.css )
