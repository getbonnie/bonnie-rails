#
class Api::BaseController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  unless Rails.application.config.consider_all_requests_local
  end

  def render_parameter_missing(e)
    render json: Api::ErrorSerializer.new(500, e).as_json, status: 500 and return false
  end

  def meta_attributes(collection, extra_meta = {})
    if collection.present?
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }.merge(extra_meta)
    else
      extra_meta
    end
  end

  protected

  def api_error(status: 500, errors: [])
    Rails.logger.info errors.full_messages if errors.respond_to?(:full_messages)
    render json: Api::ErrorSerializer.new(status, errors).as_json, status: status
  end
end
