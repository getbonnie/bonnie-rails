#
class Api::V1::FeedsController < Api::V1::BaseController
  GROUP_LIMIT = 2

  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)

    if 1 == 1
      questions_to_group = Reaction.active
                                   .group(:question_id)
                                   .having("COUNT(*) > #{GROUP_LIMIT}")
                                   .count

      grouped_questions = []
      if questions_to_group
        grouped_questions = Question.active.where(id: questions_to_group.keys).to_a
      end

      reactions = Reaction.active
                          .where.not(question_id: questions_to_group.keys)
                          .order(id: :desc)

      reactions.each_with_index do |reaction, k|
        Feed.create(
          feedable: reaction,
          source: :reaction,
          kind: :reaction
        )

        next unless k.positive? && (k % 3).zero? && grouped_questions.any?

        Feed.create(
          feedable: grouped_questions.shift,
          source: :question_first_pass,
          kind: :question_with_reactions
        )
      end

      if grouped_questions.any?
        grouped_questions.each do |question|
          Feed.create(
            feedable: question,
            source: :question_last_pass,
            kind: :question_with_reactions
          )
        end
      end
    end

    Feed.active.update_all(status: :deleted)
    Feed.pending.update_all(status: :active)
    Feed.deleted.destroy_all

    feeds = Feed.active.order(:id).page(page).per(per)

    render  json: feeds,
            root: :data,
            each_serializer: Api::V1::Feeds::FeedSerializer,
            meta: meta_attributes(feeds),
            scope: pass_scope
  end
end
