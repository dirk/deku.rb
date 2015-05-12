require 'spec_helper'

describe Deku do
  it 'has a version number' do
    expect(Deku::VERSION).not_to be nil
  end

  shared_context = nil
  shared_component = nil
  shared_node = nil

  describe Deku::Context do
    it 'should fail to initialize without V8' do
      expect {
        Deku::Context.new
      }.to raise_error(NameError)
    end

    it 'should initialize a context' do
      require 'therubyracer'
      ctx = Deku::Context.new
      expect(ctx.env).to be
      # Save the Context for later
      shared_context = ctx
    end
  end

  describe Deku::Component do
    source = <<-END.gsub(/^ {4}/, '')
    var element = require('deku').element
    module.exports = {
      render: function (component) {
        return element('div', ['Hello world!'])
      }
    }
    END

    it 'should initialize a component' do
      component = Deku::Component.new shared_context, 'component.js', source
      expect(component).to be
      # Save for later
      shared_component = component
    end
  end

  describe Deku::ElementNode do
    it 'should be rendered from a component' do
      node = shared_component.render
      expect(node).to be_a(Deku::ElementNode)
      shared_node = node
    end
  end

  describe Deku::Application do
    tree = nil
    it 'should be created from a node' do
      tree = shared_context.tree(shared_node)
      expect(tree).to be_a(Deku::Application)
    end
    it 'should render HTML string from the application tree' do
      string = shared_context.render_string tree
      expect(string).to include("<div>Hello world!</div>")
    end
  end
end

