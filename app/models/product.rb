class Product
  include Mongoid::Document
  field :name, :type => String
  field :content, :type => String
  field :category_id, type: Integer
  belongs_to :category

  def self.red
    where(name: 'red')
  end

  def to_json(options={})
    #what to do here?
    # options[:except] ||= :_id  #%w(_id)
    super(options)
  end

end