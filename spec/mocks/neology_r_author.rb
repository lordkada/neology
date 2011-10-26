require 'neology'
require 'mocks/mocks'

class NeologyRAuthor

  include Neology::RelationshipMixin

  property :score

  def self.create_custom
    { :score => 0.0 }
  end

end