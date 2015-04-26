Devise.setup do |config|
  config.secret_key = 'e7207e8c0c2921c38178a374cbdc0a50185818d8a6020638130f7a025c4454719fe7946297fc0fecb97b02e17180130aa4e604274976bf37ad1b3d3c53219891'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..128

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end
