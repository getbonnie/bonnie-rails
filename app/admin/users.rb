#
ActiveAdmin.register User do
  permit_params :name,
                :status

  filter :name_contains
  filter :status, as: :select, collection: proc { User.statuses }

  index do
    id_column
    column :name do |item|
      auto_link item, item.name
    end
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
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :status, as: :select, collection: User.statuses.keys, include_blank: false
    end
    f.actions
  end
end
