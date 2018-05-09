#
ActiveAdmin.register User do
  permit_params :name,
                :state

  filter :name_contains
  filter :state, as: :select, collection: proc { User.states }

  index do
    id_column
    column :name do |item|
      auto_link item, item.name
    end
    column :state do |item|
      status_tag item.state if item.state
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :state do |item|
        status_tag item.state if item.state
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :state, as: :select, collection: User.states, include_blank: false
    end
    f.actions
  end
end
