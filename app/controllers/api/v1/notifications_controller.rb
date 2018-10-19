# !
class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)

    notifications = Notification.where(user: current_user).order(id: :desc).page(page).per(per)

    render  json: notifications,
            root: :data,
            each_serializer: Api::V1::Notifications::NotificationSerializer,
            scope: pass_scope
  end

  def count
    unseen = Notification.where(user: current_user, seen: false).count

    render  json: {
      data: { count: unseen }
    }
  end

  def seen
    Notification.where(user: current_user, seen: false).update(seen: true)

    render json: true
  end

  def clicked
    Notification.where(uuid: params.fetch(:uuid), user: current_user).update_all(seen: true, clicked: true)

    render json: true
  end
end
