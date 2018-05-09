#
ActiveAdmin.register Category do
  permit_params :name,
                :state,
                :color

  filter :state, as: :select, collection: proc { Category.states }

  index do
    id_column
    column :name do |item|
      auto_link item, item.name
    end
    column :questions_count
    column :state do |item|
      status_tag item.state if item.state
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :color
      row :questions_count
      row :state do |item|
        status_tag item.state if item.state
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :color
      f.input :state, as: :select, collection: Category.states, include_blank: false
    end
    f.actions
  end
end
