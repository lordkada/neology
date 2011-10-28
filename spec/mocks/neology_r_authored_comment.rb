require 'neology'
require 'mocks/neology_user'

class NeologyRAuthoredComment

  include Neology::RelationshipMixin

  property :score, :type => Float

  index :score

  def init_on_create *args

    rel, source_node, dest_node, score = args

    self.score = score

  end


end