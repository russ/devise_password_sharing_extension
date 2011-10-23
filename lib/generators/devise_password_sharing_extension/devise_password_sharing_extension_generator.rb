module DevisePasswordSharingExtension
  module Generators
    class DevisePasswordSharingExtensionGenerator < Rails::Generators::NamedBase
      namespace 'devise_password_sharing_extension'

      desc 'Add :password_sharing directive in the given model. Also generate migration for ActiveRecord'

      def inject_devise_password_sharing_content
        path = File.join('app', 'models', "#{file_path}.rb")
        inject_into_file(path, 'password_sharing, :', :after => 'devise :') if File.exists?(path)
      end

      hook_for :orm
    end
  end
end
