mobi_cms:
========

With this gem/engine, we are providing to support different data sources (like - medication, movie etc.)  management without adding/developing a new AR for every data source:

Steps to use the cms engine in other app:
# To use this gem, you need to add this gem in your gem file:
- gem 'mobi_cms', git: "git@github.com:petoskey/mobi_cms.git"

# And then run:
- bundle install.

# To mount the gem with the rails application, you add below line in application config/routes.rb file:
- mount MobiCms::Engine, :at => "mobi_cms"

# To generate the engine migration, you run below command from your application:
- rake mobi_cms:install:migrations.

# Then simply run the migrations:
- rake db:migrate.

# And finally start your rails server:
- rails s
