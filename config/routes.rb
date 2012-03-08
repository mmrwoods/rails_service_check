Rails.application.routes.draw do
  match '/service_check', :to => "rails_service_check/checks#all"
  match '/service_check/:action', :controller => "rails_service_check/checks"
end
