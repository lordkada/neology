module Neology

  module GraphMixin

    def initialize inner_node
      @inner_node= inner_node
    end

    def inner_node
      @inner_node
    end

    def id
      RestUtils.get_id @inner_node
    end

  end

end