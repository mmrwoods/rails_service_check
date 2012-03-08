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

    def method_missing(m, *args)
      if RailsServiceCheck.checks.include?(m)
        begin
          RailsServiceCheck.checks[m].run
        rescue
          render :text => "#{m.to_s.humanize}: #{$!.message}", :status => 500 and return
        end
        render :text => "ok"
     else
        super
      end
    end

  end
end
