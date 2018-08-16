#
ActiveAdmin.register Comment do
  permit_params :user_id,
                :emotion_id,
                :status,
                :sound

  filter :status, as: :select, collection: proc { Pew.statuses }

  index do
    id_column
    column :hashtag do |item|
      "##{item.pew.hashtag}"
    end
    column :comment do |item|
      div do
        span item.emotion.name
        span auto_link item, item.user.name
      end
      div audio_tag(url_for(item.sound), controls: true) if item.sound.attached?
    end
    column :likes, :likes_count
    column :plays, :plays_count
    column :created_at do |item|
      time_ago(item.created_at)
    end
    column :status do |item|
      status_tag item.status if item.status
    end
    actions
  end

  show do
    attributes_table do
      row :user
      row :emotion
      row :pew do |item|
        auto_link item.pew, "##{item.pew.hashtag} from #{item.pew.user.name}"
      end
      row :in_reply_to do |item|
        if item.comment
          auto_link item.comment, "@#{item.comment.user.name} ##{item.comment.id}"
        end
      end
      if comment.sound.attached?
        row :comment do |item|
          audio_tag(url_for(item.sound), controls: true)
        end
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :likes_count
      row :plays_count
      row :uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :sound, as: :file
      f.input :user_id, as: :select, collection: User.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :emotion_id, as: :select, collection: Emotion.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :status, as: :select, collection: Pew.statuses.keys, include_blank: false
    end
    f.actions
  end
end
