module RailsServiceCheck

  class << self

    def add(label, opts={}, &block)
      if block_given?
        klass = Class.new
        klass.send(:define_method, :run) do
          block.call
        end
      else
        raise "Unknown check #{label}" unless RailsServiceCheck::Checks.constants.include?(label.to_s.camelize)
        klass = RailsServiceCheck::Checks.const_get(label.to_s.camelize)
        raise NoMethodError, "run method not declared in #{label.inspect} check" unless klass.method_defined?(:run)
      end
      checks[label.to_sym] = ( opts.empty? ? klass.new : klass.new(opts) )
    end

    def checks
      @checks ||= ActiveSupport::OrderedHash.new
    end

  end

  module Checks

    class Smtp
      def initialize(opts={})
        @address = opts[:address] || ActionMailer::Base.smtp_settings[:address] || "localhost"
        @port = opts[:port] || ActionMailer::Base.smtp_settings[:port] || 25
      end
      def run
        Net::SMTP.start(@address, @port) {}
      end
    end

    class ActiveRecordConnection
      def run
        # do nothing for the moment, connection checks for active record
        # already take place within the connection pool rack middleware.
      end
    end

  end
end
