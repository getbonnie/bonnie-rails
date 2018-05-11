#
ActiveAdmin.register User do
  menu priority: 4

  permit_params :name,
                :status,
                :avatar,
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
    column :name do |item|
      auto_link item, item.name
    end
    column 'Reactions', :reactions_count
    column 'Comments', :comments_count
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :status do |item|
        status_tag item.status if item.status
      end
      row :notifications do |item|
        status_tag 'likes' if item.notify_likes
        status_tag 'comments' if item.notify_comments
        status_tag 'features' if item.notify_features
        status_tag 'ads' if item.notify_ads
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :avatar, as: :file
      f.input :name
      f.input :status, as: :select, collection: User.statuses.keys, include_blank: false
      f.input :notify_likes
      f.input :notify_comments
      f.input :notify_features
      f.input :notify_ads
    end
    f.actions
  end
end
