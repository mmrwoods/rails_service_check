module RailsServiceCheck
  class ChecksController < ActionController::Base
    def all
      RailsServiceCheck.checks.each do |label, check|
        check.run
      end
      render :text => "ok"
    rescue Exception => e
      render :text => "#{e.message}", :status => 500 and return
    end
  end
end
