#
ActiveAdmin.register Emotion do
  menu parent: 'Tools'

  sortable
  config.sort_order = 'position_asc'
  config.paginate = false

  permit_params :name,
                :status,
                :url,
                :position

  filter :status, as: :select, collection: proc { Emotion.statuses }

  index do
    id_column
    sortable_handle_column
    column :position
    column :base64 do |item|
      render partial: 'active_admin/components/emoji', locals: { url: item.emoji_image, size: :s }
    end
    column :name do |item|
      auto_link item, item.name
    end
    column :status do |item|
      status_tag item.status if item.status
    end
    column 'Pews', :pews_count
    column 'Comments', :comments_count
    actions
  end

  show do
    attributes_table do
      row :base64 do |item|
        render partial: 'active_admin/components/emoji', locals: { url: item.emoji_image, size: :s }
      end
      row :name
      row :status do |item|
        status_tag item.status if item.status
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :status, as: :select, collection: Emotion.statuses.keys, include_blank: false
    end
    f.actions
  end
end
