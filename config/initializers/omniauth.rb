OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  # provider :facebook, '244254206357900', 'db4395bbba4127ef77f4f4d65f8e2389'

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end


# OmniAuth.config.logger = Rails.logger
# Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :facebook, Rails.application.secrets.facebook_app_id,
#  Rails.application.secrets.facebook_app_secret
# end


# OmniAuth.config.logger = Rails.logger
# Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :facebook, Rails.application.secrets.facebook_app_id,
#  Rails.application.secrets.facebook_app_secret, scope: ‘public_profile’, info_fields: ‘id,name,link’
# end
