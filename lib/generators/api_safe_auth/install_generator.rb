module ApiSafeAuth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def copy_files
        copy_file "api_safe_auth.rb", "config/initializers/api_safe_auth.rb"
      end
    end
  end
end