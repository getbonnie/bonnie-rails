#
ActiveAdmin.register Emotion do
  menu parent: 'Tools'

  permit_params :name,
                :status,
                :illustration

  filter :status, as: :select, collection: proc { Emotion.statuses }

  index do
    id_column
    column do |item|
      if item.illustration.attached?
        image_tag item.illustration.variant(combine_options: VariantLib.inside(30))
      end
    end
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
      if emotion.illustration.attached?
        row :illustration do |item|
          div image_tag item.illustration.variant(combine_options: VariantLib.inside(100))
        end
      end
      row :name
      row :questions_count
      row :status do |item|
        status_tag item.status if item.status
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :illustration, as: :file
      f.input :name
      f.input :status, as: :select, collection: Emotion.statuses.keys, include_blank: false
    end
    f.actions
  end
end
