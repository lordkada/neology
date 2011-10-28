require 'neography'
require 'neology'

$neo_server = Neology::NeoServer.new( Neography::Rest.new(:server => 'localhost', :log_enabled => true, :log_file => "  neography.log") )

def generate_text(length=8)
  chars = 'abcdefghjkmnpqrstuvwxyz'
  key   = ''
  length.times { |i| key << chars[rand(chars.length)] }
  key
end

RSpec.configure do |c|

  c.before(:all) do
    Neology::RestUtils.clear_db($neo_server.get_root)
  end

end