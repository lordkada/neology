require 'neology'
require 'mocks/neology_comment'

class NeologyUser

  include Neology::NodeMixin

  property :score, :type => Float

  index :score

  has_one(:type)
  has_n(:authored_comment)

  def init_on_create score=0
    self.score = score
  end

end