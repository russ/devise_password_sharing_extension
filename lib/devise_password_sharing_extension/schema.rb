if Devise::VERSION < "2.1"
  module DevisePasswordSharingExtension
    module Schema
      def password_sharing
        apply_devise_schema :banned_for_password_sharing_at, DateTime, :default => false
      end
    end
  end

  Devise::Schema.send(:include, DevisePasswordSharingExtension::Schema)
end
