#
class Api::V1::Users::UserSerializer < Api::V1::Users::UserRootSerializer
  attributes :following_count, :followed_count

  attribute :following do
    if current_user
      object.followed_by.where(followed_id: current_user.id).present?
    else
      false
    end
  end
end
