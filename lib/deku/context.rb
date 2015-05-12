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

    def render_string tree
      if tree['constructor']['name'] != 'Application'
        raise ArgumentError, 'Application instance tree required for rendering'
      end
      @deku['renderString'].call tree
    end

    def tree element
      if element['constructor']['name'] != 'ElementNode'
        raise ArgumentError, 'ElementNode instance required for building a tree'
      end
      @deku['tree'].call element
    end

    private

    def load_path
      File.expand_path('../../../deps/node_modules', __FILE__)
    end

  end# Context
end# Deku

