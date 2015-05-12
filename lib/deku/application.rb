module Deku
  # Abstraction around Deku's Application
  # @see https://github.com/segmentio/deku/blob/c8e9cd6e/lib/application.js#L19-L24
  class Application
    attr_reader :app

    # @param app [Object] application instance from Deku JavaScript library
    def initialize app
      if app['constructor']['name'] != 'Application'
        raise ArgumentError, 'Application instance tree required for rendering'
      end
      @app = app
    end
  end
end

