#
ActiveAdmin.register Classification do
  menu parent: 'Tools'

  permit_params :name,
                :status

  filter :status, as: :select, collection: proc { Classification.statuses }

  index do
    id_column
    column :name do |item|
      auto_link item, item.name
    end
    column :status do |item|
      status_tag item.status if item.status
    end
    column :questions_count
    actions
  end

  show do
    attributes_table do
      row :name
      row :questions_count
      row :status do |item|
        status_tag item.status if item.status
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :status, as: :select, collection: Classification.statuses.keys, include_blank: false
    end
    f.actions
  end
end
