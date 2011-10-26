require 'neology'
require 'mocks/neology_comment'

class NeologyUser

  include Neology::NodeMixin

  property :score, :type => Float

  index :score

  has_one(:type)
  has_n(:authored_comment)

  def self.create_custom
    { :score => 0.0 }
  end

end