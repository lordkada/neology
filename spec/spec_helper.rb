require 'neology'

def generate_text(length=8)
  chars = 'abcdefghjkmnpqrstuvwxyz'
  key   = ''
  length.times { |i| key << chars[rand(chars.length)] }
  key
end

RSpec.configure do |c|

  c.before(:all) do
    Neology::RestUtils.clear_db(Neology::NeoServer.get_root)
  end

end