require 'neology'

class NeologyUser

  include Neology::NodeMixin

  property :score, :type => Float

  index :score

  has_one(:type)

  def self.create_custom
    { :score => 0.0 }
  end

end