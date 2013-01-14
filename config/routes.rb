MobiCms::Engine.routes.draw do
  namespace "content_type" do 
    scope ":content_type_id" do
      resources :data_contents
    end
  end

  namespace :admin do
    resources :content_types do 
      collection do
        get :another_element
      end
    end
  end

  root :to => "dashboard#index"
end
