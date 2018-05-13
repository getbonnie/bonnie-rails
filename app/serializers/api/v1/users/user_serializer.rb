#
class Api::V1::Users::UserSerializer < Api::BaseSerializer
  attributes  :uuid,
              :name,
              :status,
              :city,
              :birthdate,
              :notify_ads,
              :notify_comments,
              :notify_features,
              :notify_likes
end
