#
class RootController < ApplicationController
  def index
    User.count
    render plain: 'Ready!'
  end
end
