Warden::Manager.after_set_user(:except => :fetch) do |record, warden, options|
  if record.respond_to?(:check_for_password_sharing!) && warden.authenticated?(options[:scope])
    record.create_login_event!(warden.request)
    record.ban_for_password_sharing if record.password_sharing?(warden.request)
  end
end
