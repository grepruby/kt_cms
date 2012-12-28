MobiCms::Engine.routes.draw do
  resources :content_types do 
    collection do
      get :another_element
    end
  end

  root :to => "content_types#index"
end
