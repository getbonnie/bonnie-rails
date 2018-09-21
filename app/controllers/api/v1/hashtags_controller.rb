#
class Api::V1::HashtagsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 20)
    keyword = params.fetch(:keyword, nil)

    hashtags = Pew.active
                  .where.not(hashtag: nil)
    hashtags = hashtags.where('hashtag LIKE ?', "%#{keyword}%") if keyword
    hashtags = hashtags.group(:hashtag)
                       .order(Arel.sql('COUNT(id) DESC'))
                       .page(page)
                       .per(per)
                       .count(:id)

    content = []
    hashtags.each do |tag|
      content.push(name: tag[0], count: tag[1])
    end

    render json: { data: content }
  end
end
