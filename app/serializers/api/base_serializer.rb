#
class Api::BaseSerializer < ActiveModel::Serializer
  def current_user
    scope[:current_user] if defined? scope[:current_user]
  end
end
