#
class Api::V1::Users::UserSerializer < Api::BaseSerializer
  attributes  :uuid,
              :name,
              :status,
              :notify_comments,
              :notify_likes,
              :notify_features,
              :notify_ads
end
