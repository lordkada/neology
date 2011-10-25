module Neology

  module GraphMixin

    def id
      RestUtils.get_id @inner_node
    end

  end

end