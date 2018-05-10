#
ActiveAdmin.register Category do
  permit_params :name,
                :status,
                :color

  filter :status, as: :select, collection: proc { Category.statuses }

  index do
    id_column
    column :name do |item|
      div style: "background-color: #{item.color}; padding: 5px; border-radius: 2px;" do
        auto_link item, item.name
      end
    end
    column :questions_count
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :color
      row :questions_count
      row :status do |item|
        status_tag item.status if item.status
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :color
      f.input :status, as: :select, collection: Category.statuses.keys, include_blank: false
    end
    f.actions
  end
end
