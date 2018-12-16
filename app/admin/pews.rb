#
ActiveAdmin.register Pew do
  menu priority: 3

  permit_params :user_id,
                :emotion_id,
                :status,
                :hashtag,
                :sound

  filter :hashtag_eq
  filter :status, as: :select, collection: proc { Pew.statuses }

  index do
    id_column
    column :hashtag do |item|
      status_tag item.hashtag.truncate(15)
    end
    column :pew do |item|
      div do
        span item.emotion.name
        span auto_link item, item.user.name
      end
      div audio_tag(url_for(item.sound), controls: true) if item.sound.attached?
    end
    column :likes, :likes_count
    column :plays, :plays_count
    column :comments, :comments_count
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
      row :hashtag do |item|
        "##{item.hashtag}"
      end
      if pew.sound.attached?
        row :pew do |item|
          audio_tag(url_for(item.sound), controls: true)
        end
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :likes_count
      row :comments_count
      row :plays_count
      row :uuid
    end

    render partial: 'comments', locals: { data: pew }
  end

  form do |f|
    f.inputs do
      f.input :sound, as: :file
      f.input :user_id, as: :select, collection: User.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :hashtag
      f.input :emotion_id, as: :select, collection: Emotion.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :status, as: :select, collection: Pew.statuses.keys, include_blank: false
    end
    f.actions
  end
end
