require 'neology'
require 'mocks/neology_comment'
require 'mocks/neology_r_authored_comment'

class NeologyUser

  include Neology::NodeMixin

  property :score, :type => Float

  index :score

  has_one(:type)
  has_n(:authored_comment).relationship( NeologyRAuthoredComment )

  def init_on_create score=0
    self.score = score
  end

end