#
ActiveAdmin.register Topic do
  menu priority: 1

  permit_params :name,
                :content,
                :sticker,
                :category_id,
                :status,
                :tag

  filter :status, as: :select, collection: proc { Topic.statuses }

  index do
    id_column
    column :sticker do |item|
      if item.sticker.attached?
        image_tag item.sticker.variant(VariantLib.inside(30))
      end
    end
    column :name do |item|
      auto_link item, item.name
    end
    column :tag do |item|
      "##{item.tag}"
    end
    column :status do |item|
      status_tag item.status if item.status
      status_tag item.category.name if item.category
    end
    column :questions_count
    actions
  end

  show do
    attributes_table do
      row :view do |item|
        render partial: 'active_admin/components/topic', locals: { topic: item }
      end
      row :category do |item|
        item.category.name if item.category
      end
      row :tag do |item|
        "##{item.tag}"
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :uuid
    end

    panel 'Questions' do
      topic.questions.each do |question|
        render partial: 'active_admin/components/question', locals: { question: question }
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :sticker, as: :file
      f.input :name
      f.input :tag
      f.input :category, as: :select, collection: Category.all.map { |i| [i.name, i.id] }
      f.input :content, as: :text, input_html: { rows: 6 }
      f.input :status, as: :select, collection: Topic.statuses.keys, include_blank: false
    end
    f.actions
  end
end
