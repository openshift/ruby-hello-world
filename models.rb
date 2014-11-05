require 'active_record'

class KeyPair < ActiveRecord::Base
    self.primary_key = 'key'
end
