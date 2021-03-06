module Deku
  class Component
    # @param context [Deku::Context] context to use for instantiating
    # @param name [String] name of the component
    # @param source [String] source of the component
    def initialize context, name, source
      @context = context; @name = name; @source = source

      loader_source = create_loader source
      loader_func   = @context.env.runtime.eval(loader_source, name)
      # Create a module for this source
      @mod = CommonJS::Module.new name, @context.env
      # Call the loading function with the module
      loader_func.call(@mod, @mod.require_function, @mod.exports)
    end

    # @param key [String] retrieve object from component module's exports
    # @return [Object] JavaScript object
    def [](key)
      @mod.exports[key]
    end

    # @return [Object] call the JavaScript `render()` function of the
    #   component's module
    def render
      ElementNode.new(@mod.exports['render'].call)
    end

    private

    def create_loader source
      "( function(module, require, exports) {\n#{source}\n} )"
    end
  end
end

