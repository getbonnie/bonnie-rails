#
class Api::ErrorSerializer
  UNKNOWN_ERROR = 'Something went wrong, no more info is available unforunately!'.freeze
  DEFAULT_POINTER = 'data'.freeze

  def initialize(status, errors)
    @status = status
    @errors = if errors.is_a? ActiveModel::Errors
                parse_am_errors(errors)
              # it's an array or a string
              else
                @errors = [errors].flatten
              end
  end

  def as_json
    { errors: errors }
  end

  delegate :to_json, to: :as_json

  private

  def parse_am_errors(errors)
    error_messages = errors.full_messages

    errors.map.with_index do |(k, v), i|
      ErrorDecorator.new(k, v, error_messages[i])
    end
  end

  def errors
    @errors.map do |error|
      {
        status: @status,
        title: normalize_title(error),
        detail: normalize_error(error),
        source: {
          pointer: error_pointer(error)
        }
      }
    end
  end

  def normalize_title(error)
    error.try(:title) || error.try(:to_s) || UNKNOWN_ERROR
  end

  def normalize_error(error)
    error.try(:details) || error.try(:to_s) || UNKNOWN_ERROR
  end

  def error_pointer(error)
    if error.respond_to?(:pointer)
      error.pointer
    else
      DEFAULT_POINTER
    end
  end

  #
  class ErrorDecorator
    def initialize(key, value, message)
      @key = key
      @value = value
      @message = message
    end

    def title
      @value
    end

    def details
      @value
    end

    def to_s
      @message
    end

    def pointer
      "data/attributes/#{@key}"
    end
  end
end
