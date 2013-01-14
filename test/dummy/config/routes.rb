Rails.application.routes.draw do

  # This line mounts mobi_cms's routes at /mobi_cms by default.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #

  mount MobiCms::Engine, :at => '/mobi_cms'

  mount MobiAuth::Engine => "/auth", as: :auth
  mount MobiCms::Engine => "/mobi_cms"

  root :to => "welcome#index"
end
