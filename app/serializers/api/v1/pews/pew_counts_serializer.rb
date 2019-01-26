# !
class Api::V1::Pews::PewCountsSerializer < Api::BaseSerializer
  attributes  :uuid,
              :likes_count,
              :comments_count
end
