class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w( www admin followmd app application)
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

class MaindomainConstraint
  def self.matches?(request)
    subdomains = %w( www admin followmd app application)
    !request.subdomain.present? || subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints SubdomainConstraint do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'

    root 'home#dashboard'
  end

  constraints MaindomainConstraint do
    root 'landing#index'

    get 'about', to: 'landing#about'
    get 'pricing', to: 'pricing#index'
    get 'tos', to: 'legal#tos'
    get 'privacy', to: 'legal#privacy'
  end
end
