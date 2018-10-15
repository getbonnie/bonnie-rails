# !
class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    render  json: @user,
            root: :data,
            serializer: Api::V1::Notifications::NotificationSerializer,
            scope: pass_scope
  end
end
