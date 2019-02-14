#
ActiveAdmin.register Flag do

  permit_params :flagable_type,
                :flagable_id,
                :user_id,
                :kind,
                :status

  filter :kind, as: :select, collection: proc { Flag.kinds }

  index do
    id_column
    column :flagable
    column :user
    column :kind do |item|
      status_tag item.kind if item.kind
    end
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :flagable
      row :user
      row :kind do |item|
        status_tag item.kind if item.kind
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Flag.statuses.keys, include_blank: false
      f.input :kind, as: :select, collection: Flag.kinds.keys, include_blank: false
    end
    f.actions
  end
end
