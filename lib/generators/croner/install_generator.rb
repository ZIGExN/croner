module Croner
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Croner initializer to your application."

      def copy_initializer
        template "croner.rb", "config/initializers/croner.rb"
      end
    end
  end
end
