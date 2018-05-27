#
class Api::V1::TopicsController < Api::V1::BaseController
  def show
    topic = Topic.active.find_by(uuid: params.fetch(:uuid))
    api_error(status: 404, errors: 'Topic missing') and return false unless topic

    render  json: topic,
            root: :data,
            serializer: Api::V1::Topics::TopicSerializer,
            scope: pass_scope
  end
end
