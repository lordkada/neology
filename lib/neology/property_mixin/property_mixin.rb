require 'neology/property_mixin/class_methods'

module Neology

  module PropertyMixin

    def self.included(base)

      base.extend(Neology::PropertyMixin::ClassMethods)

    end

  end

end