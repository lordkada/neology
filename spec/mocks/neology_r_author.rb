require 'neology'
require 'mocks/mocks'

class NeologyRAuthor

  include Neology::RelationshipMixin

  property :score

  def init_on_create
    self.score = 0.0
  end

end