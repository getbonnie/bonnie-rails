#
class Api::V1::Users::MeSerializer < Api::V1::Users::UserRootSerializer
  attributes  :status,
              :notify_ads,
              :notify_comments,
              :notify_features,
              :notify_likes
end
