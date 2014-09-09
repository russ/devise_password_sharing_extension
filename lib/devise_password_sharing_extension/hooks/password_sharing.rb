Warden::Manager.after_set_user(except: :fetch) do |record, warden, options|
  if record.respond_to?(:password_sharing?) && warden.authenticated?(options[:scope])
    if handler = Devise.banning_handler
      handler.call(record, warden.request.remote_ip)
    else
      record.create_login_event!(warden.request.remote_ip)
      if record.password_sharing?
        record.ban_for_password_sharing!
        scope = options[:scope]
        warden.logout(scope)
        throw :warden, :scope => scope, :message => 'Account banned for password sharing.'
      end
    end
  end
end
