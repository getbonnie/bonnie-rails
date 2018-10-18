# !
class Api::V1::Pews::PewSerializer < Api::V1::Pews::PewRootSerializer
  belongs_to :user, serializer: Api::V1::Users::UserSerializer
end
