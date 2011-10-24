Warden::Manager.after_set_user(:except => :fetch) do |record, warden, options|
  if record.respond_to?(:password_sharing?) && warden.authenticated?(options[:scope])
    record.create_login_event!(warden.request)

    if record.password_sharing?
      record.ban_for_password_sharing
      scope = options[:scope]
      warden.logout(scope)
      throw :warden, :scope => scope, :message => 'Account banned for password sharing.'
    end
  end
end
