require 'neology'

class NeologyComment

  include Neology::NodeMixin

  has_one(:author).to(NeologyUser).relationship(NeologyRAuthor)

  has_n(:voters).to(NeologyUser)

end