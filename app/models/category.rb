class Category
  include Mongoid::Document
  field :name, type: String
  has_many :products

include ActiveModel::Serializers::JSON

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end
end
