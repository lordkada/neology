require 'neology'
require 'mocks/mocks'

class NeologyRAuthor

  include Neology::RelationshipMixin

  property :score

  def init_on_create relationship_name, source_wrapper, destination_wrapper
    self.score = 0.0
  end

end