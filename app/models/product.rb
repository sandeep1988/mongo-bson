# require 'bson'
# require 'json'
class Product
  include Mongoid::Document
  field :name, :type => String
  field :content, :type => String
end