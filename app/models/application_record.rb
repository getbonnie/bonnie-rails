#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def upload_cache
    GoogleCloud.instance.upload_cache
  end
end
