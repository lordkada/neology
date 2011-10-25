require 'neography'

module Neology

  class NeoServer

    def self.get

      $neo_server ||= Neography::Rest.new(:server => 'localhost', :log_enabled => true, :log_file => "../neography.log" )

    end

  end

end