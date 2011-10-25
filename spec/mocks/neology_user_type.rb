require 'neology'

class NeologyUserType

  include Neology::NodeMixin

  property :user_type

  has_n(:user)

end