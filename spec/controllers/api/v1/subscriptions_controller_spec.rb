require 'rails_helper'
# !
RSpec.describe Api::V1::SubscriptionsController, type: :controller do
  it 'deletes sub pew' do
    subscription = create(:notification_subscription)

    request.headers[:user] = subscription.user_id
    delete :unfollow_pew, params: { uuid: subscription.pew.uuid }

    expect(response.status).to eq(200)

    expect(NotificationSubscription.count).to eq(0)
  end

  it 'deactivate my own pew notifications' do
    pew = create(:pew)

    request.headers[:user] = pew.user_id
    delete :unfollow_pew, params: { uuid: pew.uuid }

    expect(response.status).to eq(200)

    expect(pew.reload.notify).to eq(false)
  end

  it 'deletes comment sub' do
    comment = create(:comment)

    request.headers[:user] = comment.user_id
    delete :unfollow_comment, params: { uuid: comment.uuid }

    expect(response.status).to eq(200)
    expect(comment.reload.notify).to eq(false)
  end
end
