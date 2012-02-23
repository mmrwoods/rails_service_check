Rails.application.routes.draw do
  match '/service_check', :to => "rails_service_check/checks#all"
end
