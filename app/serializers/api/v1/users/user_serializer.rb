#
class Api::V1::Users::UserSerializer < Api::BaseSerializer
  attributes  :uuid,
              :name,
              :city,
              :birthdate

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
