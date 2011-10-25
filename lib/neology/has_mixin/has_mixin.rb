require 'neology/has_mixin/class_methods'

module Neology

  module HasMixin

    def self.included(base)

      base.extend(Neology::HasMixin::ClassMethods)

    end

  end

end