require 'neology'
require 'mocks/neology_user'
require 'mocks/neology_r_author'

class NeologyComment

  include Neology::NodeMixin

  has_one(:author).to(NeologyUser).relationship(NeologyRAuthor)

  has_n(:voters).to(NeologyUser)

end