#
class Api::V1::Questions::QuestionBasicSerializer < Api::BaseSerializer
  attributes  :uuid,
              :short,
              :long
end
