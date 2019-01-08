#
ActiveAdmin.register Notification do
  menu parent: 'Tools'

  filter :sent
  filter :seen
  filter :clicked

  # Re-send
  member_action :resend, method: :get do
    resource.user.devices.each do |device|
      resource.update(sent: true) if FcmLib.send_notification_success?(
        device.token,
        resource.phrase,
        resource.user.notifications.where(seen: false).count
      )
    end

    redirect_to notifications_path, notice: 'Resent !'
  end

  index do
    id_column
    column :user
    column :from
    column :phrase
    column :seen
    column :sent
    column :clicked
    column :tool do |item|
      link_to 'Resend', resend_notification_path(item.id)
    end
  end
end
