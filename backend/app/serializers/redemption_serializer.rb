class RedemptionSerializer
  include JSONAPI::Serializer
  attributes :id, :created_at, :reward
end
