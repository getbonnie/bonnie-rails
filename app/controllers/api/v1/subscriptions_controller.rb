# !
class Api::V1::SubscriptionsController < Api::V1::BaseController
  def unfollow_pew
    pew = Pew.find_by(uuid: params.fetch(:uuid))

    api_error(status: 404, errors: 'Pew missing') and return false if pew.blank?

    # Deactivate notify on my own Pew
    if pew.user_id == current_user.id
      pew.update(notify: false)

    # Unsubscribe notify on other pews
    else
      subscription = NotificationSubscription.where(user: current_user, pew: pew)

      api_error(status: 404, errors: 'Subscription missing') and return false if subscription.blank?
      subscription.destroy_all
    end

    render json: true
  end

  def unfollow_comment
    subscription = Comment.find_by(user: current_user, uuid: params.fetch(:uuid))

    api_error(status: 404, errors: 'Comment missing') and return false if subscription.blank?

    subscription.update(notify: false)

    render json: true
  end
end
