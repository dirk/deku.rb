module Deku
  # Abstraction around Deku's ElementNode
  # @see https://github.com/segmentio/deku/blob/c8e9cd6e/lib/virtual.js#L139-L145
  class ElementNode
    attr_reader :node

    # @param node [Object] JavaScript node from Component#render
    def initialize node
      # Check that we actually got a JavaScript ElementNode
      if node['constructor']['name'] != 'ElementNode'
        raise ArgumentError, 'ElementNode JavaScript object required'
      end
      @node = node
    end
  end
end

