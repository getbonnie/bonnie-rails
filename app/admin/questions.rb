#
ActiveAdmin.register Question do
  menu priority: 2

  permit_params :short,
                :long,
                :topic_id,
                :classification_id,
                :status

  filter :short_contains
  filter :status, as: :select, collection: proc { Question.statuses }

  index do
    id_column
    column :question do |item|
      render partial: 'active_admin/components/question_small', locals: { question: item }
    end
    column :reactions_count
    column :tags do |item|
      status_tag item.classification.name if item.classification
    end
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :display do |item|
        render partial: 'active_admin/components/question', locals: { question: item }
      end
      row :short
      row :long
      row :tags do |item|
        status_tag item.classification.name if item.classification
        status_tag item.status if item.status
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :topic_id, as: :select, collection: Topic.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :classification_id, as: :select, collection: Classification.all.map { |i| [i.name, i.id] }
      f.input :short, input_html: { maxlength: 60 }
      f.input :long, as: :text, input_html: { rows: 3 }
      f.input :status, as: :select, collection: Question.statuses.keys, include_blank: false
    end
    f.actions
  end
end
