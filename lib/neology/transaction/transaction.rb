require 'neography'
require 'neology/neo_server'

module Neology

  class Transaction

    def self.run

      ret = yield tx

    end

  end
end