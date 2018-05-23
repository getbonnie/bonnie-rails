#
class Api::V1::Users::MeSerializer < Api::BaseSerializer
  attributes  :uuid,
              :name,
              :status,
              :city,
              :birthdate,
              :notify_ads,
              :notify_comments,
              :notify_features,
              :notify_likes

  attribute :avatar do
    if object.avatar.attachment
      Rails.application.routes.url_helpers.rails_representation_url(
        object.avatar.variant(
          VariantLib.inside(100)
        )
      )
    end
  end
end
