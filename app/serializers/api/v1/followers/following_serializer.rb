#
class Api::V1::Followers::FollowingSerializer < Api::BaseSerializer
  belongs_to :user, serializer: Api::V1::Users::UserRootSerializer

  attributes  :id,
              :created_at

  def user
    object.following
  end
end
