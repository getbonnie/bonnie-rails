# !
class Api::V1::Comments::CommentCountsSerializer < Api::BaseSerializer
  attributes  :uuid,
              :likes_count
end
