module RailsServiceCheck
  class ChecksController < ActionController::Base
    def all
      RailsServiceCheck.checks.each do |label, check|
        begin
          check.run
        rescue
          render :text => "#{label.to_s.humanize}: #{$!.message}", :status => 500 and return
        end
      end
      render :text => "ok"
    end
  end
end
