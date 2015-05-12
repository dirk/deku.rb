require 'commonjs'

module Deku
  # Abstraction over V8::Context and other JavaScript-in-Ruby APIs
  class Context
    attr_reader :env

    def initialize ctx = nil
      ctx = V8::Context.new if ctx.nil?
      # Save the context and setup the Deku load path
      @ctx = ctx
      @env = CommonJS::Environment.new @ctx, path: load_path
      # Load the Deku JS library in the context
      @deku = @env.require 'deku'
    end

    # @return [String] string rendering of the application tree
    def render_string application
      @deku['renderString'].call application.app
    end

    # @param element [ElementNode]
    # @return [Application]
    def tree element
      # if element['constructor']['name'] != 'ElementNode'
      #   raise ArgumentError, 'ElementNode instance required for building a tree'
      # end
      Application.new(@deku['tree'].call element.node)
    end

    private

    def load_path
      File.expand_path('../../../deps/node_modules', __FILE__)
    end
  end# Context
end# Deku

