module RailsServiceCheck
  class ChecksController < ActionController::Base
    def all
      RailsServiceCheck::Checks.methods(false).each do |method|
        RailsServiceCheck::Checks.send(method)
      end
      render :text => "ok"
    rescue Exception => e
      render :text => "#{e.message}", :status => 500 and return
    end
  end
end
