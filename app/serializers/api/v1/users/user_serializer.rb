#
class Api::V1::Users::UserSerializer < Api::V1::Users::UserRootSerializer
  attributes :following_count, :followed_count
end
