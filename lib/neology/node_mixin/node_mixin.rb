require 'neology/graph_mixin/graph_mixin'
require 'neology/property_mixin/property_mixin'
require 'neology/has_mixin/has_mixin'
require 'neology/index_mixin/index_mixin'
require 'neology/node_mixin/class_methods'

module Neology

  module NodeMixin

    def initialize inner_node
      @inner_node= inner_node
    end

    def inner_node
      @inner_node
    end

    include Neology::GraphMixin
    include Neology::HasMixin

    def self.included(base)

      base.extend Neology::NodeMixin::ClassMethods
      base.extend Neology::PropertyMixin::ClassMethods
      base.extend Neology::HasMixin::ClassMethods
      base.extend Neology::IndexMixin::ClassMethods

    end

  end

end