require 'rails/generators'
module MobiCms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current-user-helper", :type => :string

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install MobiCms"

      def install_migrations
        puts "Copying over mobi_cms migrations..."
        Dir.chdir(Rails.root) do
          `rake mobi_cms:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end

      def determine_current_user_helper
        current_user_helper = options["current-user-helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

        puts "Defining mobi_cms_user method inside ApplicationController..."

        mobi_cms_user_method = %Q{
  def mobi_cms_user
    #{current_user_helper}
  end
  helper_method :mobi_cms_user

}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         mobi_cms_user_method,
                         :after => "ActionController::Base\n")

      end

      def add_mobi_cms_initializer
        path = "#{Rails.root}/config/initializers/mobi_cms.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/mobi_cms.rb creation, as file already exists!"
        else
          puts "Adding mobi_cms initializer (config/initializers/mobi_cms.rb)..."
          template "initializer.rb", path
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end


      def mount_engine
        puts "Mounting MobiCms::Engine at \"/mobi_cms\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  # This line mounts mobi_cms's routes at /mobi_cms by default.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #

  mount MobiCms::Engine, :at => '/mobi_cms'

}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! MobiCms has been successfully installed. Yaaaaay!

Here's what happened:\n\n}

        output += step("MobiCms migrations were copied over into db/migrate.\n")
        output += step("A new method called `mobi_cms_user` was inserted into your ApplicationController.
   This lets MobiCms know what the current user of your application is.\n")
        output += step("A new file was created at config/initializers/mobi_cms.rb
   This is where you put MobiCms configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount MobiCms::Engine, :at => \"/mobi_cms\"

   If you want to change where the mobi_cms are located, just change the \"/mobi_cms\" path at the end of this line to whatever you want.")
        output += %Q{\nAnd finally:

#{step("We told you that MobiCms has been successfully installed and walked you through the steps.")}}


        output += "Thanks for using MobiCms!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
