class Product
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :name, :type => String
  field :content, :type => String
  field :category_id, type: Integer
  field :user_id, type: Integer
  field :published_on, :type => Date
  belongs_to :category
  belongs_to :user

  def self.red
    where(name: 'red')
  end

  def self.today
    where(:created_at >= Time.zone.now.beginning_of_day)
  end

end