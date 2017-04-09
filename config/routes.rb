Rails.application.routes.draw do
  resources :users, :groups, shallow: true do
    resources :lists, shallow: true do
      resources :items
    end

    resources :items
  end
end
