#
ActiveAdmin.register Reaction do
  permit_params :user_id,
                :question_id,
                :emotion_id,
                :state,
                :sound

  filter :state, as: :select, collection: proc { Reaction.states }

  index do
    id_column
    column :topic do |item|
      if item.question&.topic && item.question.topic.sticker.attached?
        image_tag item.question.topic.sticker.variant(combine_options: VariantLib.inside(30))
      end
    end
    column :emotion
    column :reaction do |item|
      div item.user.name
      div item.question.short
      div audio_tag(url_for(item.sound), controls: true) if item.sound.attached?
    end
    column :state do |item|
      status_tag item.state if item.state
    end
    actions
  end

  show do
    attributes_table do
      row :user
      row :emotion
      row :question do |item|
        auto_link item.question, item.question.short
      end
      if reaction.sound.attached?
        row :reaction do |item|
          audio_tag(url_for(item.sound), controls: true)
        end
      end
      row :state do |item|
        status_tag item.state if item.state
      end
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :sound, as: :file
      f.input :user_id, as: :select, collection: User.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :question_id, as: :select, collection: Question.all.map { |i| [i.short, i.id] }, include_blank: false
      f.input :emotion_id, as: :select, collection: Emotion.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :state, as: :select, collection: Question.states, include_blank: false
    end
    f.actions
  end
end
