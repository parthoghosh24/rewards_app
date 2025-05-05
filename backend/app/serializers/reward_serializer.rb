class RewardSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :points
end
