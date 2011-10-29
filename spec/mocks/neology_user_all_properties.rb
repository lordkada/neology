require 'neology'

class NeologyUserAllProperties

  include Neology::NodeMixin

  property :float_type, :type => Float
  property :string_type, :type => String
  property :integer_type, :type => Integer

end