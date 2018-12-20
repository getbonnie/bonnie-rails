#
ActiveAdmin.register User do
  menu priority: 4

  permit_params :name,
                :status,
                :avatar,
                :city,
                :birthdate,
                :notify_likes,
                :notify_comments,
                :notify_features,
                :notify_ads

  filter :name_contains
  filter :status, as: :select, collection: proc { User.statuses }

  index do
    id_column
    column :avatar do |item|
      render partial: 'active_admin/components/avatar', locals: { avatar: item.avatar, size: :s }
    end
    column :name
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :birthdate
      row :city do |item|
        span item.city
        if item.latitude && item.longitude
          span "(Latitude: #{item.latitude} Longitude: #{item.longitude})"
        end
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :notifications do |item|
        status_tag 'likes' if item.notify_likes
        status_tag 'comments' if item.notify_comments
        status_tag 'features' if item.notify_features
        status_tag 'ads' if item.notify_ads
      end
      row :phone
      row :ref_firebase
      row :jwt do |item|
        JwtTokenLib.encode(uuid: item.uuid)
      end
      row :uuid
    end

    panel 'Devices' do
      table_for user.devices.order(id: :desc) do
        column :id
        column :reference
        column :token do |item|
          item.token.truncate(100)
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :avatar, as: :file
      f.input :name
      f.input :birthdate, start_year: Time.now.utc.year - 90, as: :date_picker
      f.input :city
      f.input :status, as: :select, collection: User.statuses.keys, include_blank: false
      f.input :notify_likes
      f.input :notify_comments
      f.input :notify_features
      f.input :notify_ads
    end
    f.actions
  end
end
