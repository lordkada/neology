require 'neology'

class NeologyRelationshipAllProperties

  include Neology::RelationshipMixin

  property :float_type, :type => Float
  property :string_type, :type => String
  property :integer_type, :type => Integer

end