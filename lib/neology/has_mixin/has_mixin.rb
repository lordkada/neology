require 'neology/has_mixin/class_methods'

module Neology

  module HasMixin

    def relationships_values_hash
      @relationships_values_hash||={}
    end

=begin
    def self.included(base)

      base.extend(Neology::HasMixin::ClassMethods)

    end
=end

  end

end