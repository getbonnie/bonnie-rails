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

    render json: { data: hashtags }
  end
end
