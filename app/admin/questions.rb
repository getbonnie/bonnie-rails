#
ActiveAdmin.register Question do
  permit_params :short,
                :long,
                :question,
                :topic_id,
                :category_id,
                :state

  filter :short_contains
  filter :state, as: :select, collection: proc { Question.states }

  index do
    id_column
    column :topic do |item|
      if item&.topic && item.topic.sticker.attached?
        image_tag item.topic.sticker.variant(combine_options: VariantLib.inside(30))
      end
    end
    column :question do |item|
      auto_link item, item.short
    end
    column :reactions_count
    column :topic do |item|
      status_tag item.topic.name if item.topic
    end
    column :state do |item|
      status_tag item.state if item.state
    end
    actions
  end

  show do
    attributes_table do
      if question&.topic && question.topic.sticker.attached?
        row :topic do |item|
          image_tag item.topic.sticker.variant(combine_options: VariantLib.inside(100))
        end
      end
      row :short
      row :long
      row :question
      row :tags do |item|
        status_tag item.category.name if item.category
        status_tag item.state if item.state
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :topic_id, as: :select, collection: Topic.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :category_id, as: :select, collection: Category.all.map { |i| [i.name, i.id] }
      f.input :short, input_html: { maxlength: 60 }
      f.input :long, as: :text, input_html: { rows: 3 }
      f.input :question, as: :text, input_html: { rows: 3 }
      f.input :state, as: :select, collection: Question.states, include_blank: false
    end
    f.actions
  end
end
