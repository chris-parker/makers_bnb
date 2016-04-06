require 'data_mapper'
require 'dm-postgres-adapter'

class Space
  include DataMapper::Resource

  has n, :requests
  belongs_to :user

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, String

end
