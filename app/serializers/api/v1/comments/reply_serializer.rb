#
class Api::V1::Comments::ReplySerializer < Api::BaseSerializer
  attributes  :uuid

  attribute :name do
    object.user.name
  end
end
