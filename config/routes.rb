MobiCms::Engine.routes.draw do
  resources :content_types do 
    collection do
      get :another_element
    end
    resources :data_contents
  end

  root :to => "content_types#index"
end
