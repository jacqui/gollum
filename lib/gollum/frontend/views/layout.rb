require 'cgi'

module Precious
  module Views
    class Layout < Mustache
      include Rack::Utils
      include Precious::UrlHelpers
      alias_method :h, :escape_html

      # without this, the url helpers don't work in some rails apps due to: voodoo
      attr_accessor :request

      attr_reader :name

      def escaped_name
        CGI.escape(@name)
      end

      def title
        "Home"
      end
    end
  end
end
