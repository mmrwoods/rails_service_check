module RailsServiceCheck
  # temporary dumping ground for service checks, one class method per check
  # TODO: refactor this fscking mess, possibly using command pattern
  class Checks
    class << self
      def db
        # do nothing for the moment, connection checks for active record
        # already take place within the connection pool rack middleware.
        # This is shit though, assumes we're using AR for a start.
      end
      def smtp
        address = ActionMailer::Base.smtp_settings[:address] || "localhost"
        port = ActionMailer::Base.smtp_settings[:port] || 25
        Net::SMTP.start(address, port) {}
      end
    end
  end
end
