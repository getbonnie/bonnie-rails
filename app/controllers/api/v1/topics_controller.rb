#
class Api::V1::TopicsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 100)

    topics = Topic.active.page(page).per(per)
    render  json: topics,
            root: :data,
            each_serializer: Api::V1::Topics::TopicSerializer,
            meta: meta_attributes(topics),
            scope: pass_scope
  end
end
