require 'neology/neo_server'

module Neology

  class Transaction

    def self.run

      ret = yield tx

    end

    def success

    end

    def finish

    end

    def failure

    end

  end

end