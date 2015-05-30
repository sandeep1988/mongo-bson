module Moped
  module BSON
    class ObjectId
      def to_json(*args)
        to_s.to_bson
      end
    end
  end
end