class UserPointSerializer
  include JSONAPI::Serializer
  attributes :id, :user, :points
end
