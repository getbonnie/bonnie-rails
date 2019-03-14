#
ActiveAdmin.register Pew do
  menu priority: 3

  permit_params :user_id,
                :emotion_id,
                :status,
                :inline_hashtags,
                :sound

  filter :inline_hashtags
  filter :status, as: :select, collection: proc { Pew.statuses }

  index do
    id_column
    column :pew do |item|
      div class: 'username' do
        render partial: 'active_admin/components/emoji', locals: { url: item.emotion.emoji_image, size: :xs }
        span auto_link item, item.user.name
      end
      div audio_tag(url_for(item.sound), controls: true, class: :player) if item.sound.attached?
    end
    column :hashtag do |item|
      div do
        item.inline_hashtags.split.each do |hashtag|
          div status_tag "##{hashtag}"
        end
      end
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
      row :emotion do |item|
        render partial: 'active_admin/components/emoji', locals: { url: item.emotion.emoji_image, size: :s }
      end
      row :hashtags do |item|
        div do
          item.hashtags.each do |hashtag|
            span status_tag "##{hashtag.tag}"
          end
        end
      end
      if pew.sound.attached?
        row :pew do |item|
          audio_tag(url_for(item.sound), controls: true, class: :player)
        end
      end
      row :status do |item|
        status_tag item.status if item.status
      end
      row :duration do |item|
        "#{(item.duration/1000).round(1)} s." if item.duration
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
      f.input :inline_hashtags
      f.input :emotion_id, as: :select, collection: Emotion.all.map { |i| [i.name, i.id] }, include_blank: false
      f.input :status, as: :select, collection: Pew.statuses.keys, include_blank: false
    end
    f.actions
  end
end
