#
class Api::V1::HashtagsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 20)
    keyword = params.fetch(:keyword, nil)

    hashtags = Hashtag.select(:tag)
    hashtags = hashtags.where('lower_tag LIKE ?', "%#{keyword.downcase}%") if keyword
    hashtags = hashtags.page(page)
                       .per(per)
                       .group(:tag)
                       .order('COUNT(tag) DESC')
                       .count

    content = []
    hashtags.each do |tag|
      content.push(name: tag[0], count: tag[1])
    end

    render json: { data: content }
  end
end
