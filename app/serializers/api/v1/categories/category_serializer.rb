#
class Api::V1::Categories::CategorySerializer < Api::BaseSerializer
  attributes  :id,
              :name,
              :color
end
