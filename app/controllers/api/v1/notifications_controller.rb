# !
class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    notifications = Notification.where(user: current_user).order(id: :desc)

    render  json: notifications,
            root: :data,
            each_serializer: Api::V1::Notifications::NotificationSerializer,
            scope: pass_scope
  end
end
