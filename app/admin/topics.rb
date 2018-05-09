#
ActiveAdmin.register Topic do
  permit_params :name,
                :content,
                :sticker,
                :state

  filter :state, as: :select, collection: proc { Topic.states }

  index do
    id_column
    column :sticker do |item|
      if item.sticker.attached?
        image_tag item.sticker.variant(combine_options: VariantLib.inside(30))
      end
    end
    column :name do |item|
      auto_link item, item.name
    end
    column :state do |item|
      status_tag item.state if item.state
    end
    column :questions_count
    actions
  end

  show do
    attributes_table do
      if topic.sticker.attached?
        row :sticker do |item|
          div image_tag item.sticker.variant(combine_options: VariantLib.inside(100))
        end
      end
      row :name
      row :content
      row :state do |item|
        status_tag item.state if item.state
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :sticker, as: :file
      f.input :name
      f.input :content, input_html: { type: "text" }
      f.input :state, as: :select, collection: Topic.states, include_blank: false
    end
    f.actions
  end
end
