require 'neology'
require 'mocks/mocks'

class NeologyUserType

  include Neology::NodeMixin

  property :user_type

  has_n(:user).to( NeologyUser )

end