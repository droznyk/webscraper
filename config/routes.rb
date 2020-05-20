Rails.application.routes.draw do
  resources :scrapers do
    resources :rulesets, except: [:index] do
      get 'scrape', to: 'rulesets#scrape', as: 'single_scrape'
    end
  end

  resources :scrape_results, only: %i(show edit update destroy)

  root 'scrapers#index'
end
