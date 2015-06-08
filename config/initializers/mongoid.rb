module Moped
  module BSON
    class ObjectId
      alias :to_json :to_s
      alias :as_json :to_s
    end
  end
end

module Mongoid
  module Document
    def serializable_hash(options = nil)
      h = super(options)
      h['id'] = h.delete('_id') if(h.has_key?('_id'))
      h
    end
  end
end


module BSON
  class Code
    def to_s
      inspect
    end
  end
end

