# !
class Api::V1::DevicesController < Api::V1::BaseController
  def touch
    device_params = params.require(:device).permit(
      :reference,
      :token
    ).tap do |i|
      i.require(:reference)
      i.require(:token)
    end

    reference = device_params.fetch(:reference)
    token = device_params.fetch(:token)

    device = Device.where(user: current_user, reference: reference)
                   .first_or_create

    device.update(token: token)

    render json: true
  end
end
