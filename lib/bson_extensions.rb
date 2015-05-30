module ObjectIdExtensions
  def __bson_dump__(io, key)
    # construct a Moped BSON Object Id
    obj_id = Moped::BSON::ObjectId(self.to_s)
    obj_id.send :__bson_dump__, io, key
  end
end

unless BSON::ObjectId.instance_methods.include?(:__bson_dump__)

  BSON::ObjectId.class_eval do
    include ObjectIdExtensions
  end

end