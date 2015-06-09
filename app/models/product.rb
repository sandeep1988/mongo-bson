class Product
  include Mongoid::Document
  field :name, :type => String
  field :content, :type => String
  field :category_id, type: Integer
  field :user_id, type: Integer
  belongs_to :category
  belongs_to :user
  
  def self.red
    where(name: 'red')
  end
end