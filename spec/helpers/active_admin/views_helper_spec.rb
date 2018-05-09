require 'rails_helper'

#
RSpec.describe ActiveAdmin::ViewsHelper, type: :helper do
  it 'succeeds for today' do
    delay = time_ago(Time.zone.now)
    expect(delay).to match(/Today, .*/)
  end

  it 'succeeds for future' do
    delay = time_ago(Time.zone.now + 2.days)
    expect(delay).to match(/in .*/)
  end

  it 'succeeds for past' do
    delay = time_ago(Time.zone.now - 2.days)
    expect(delay).to match(/.* ago/)
  end
end
