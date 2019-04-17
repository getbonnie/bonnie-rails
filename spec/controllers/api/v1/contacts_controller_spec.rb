require 'rails_helper'
# !
RSpec.describe Api::V1::ContactsController, type: :controller do
  it 'imports' do

    data = [{"name":"Kate Bell","phone_numbers":["(555) 564-8583","(415) 555-3695"]},{"name":"Daniel Higgins","phone_numbers":["555-478-7672","(408) 555-5270","(408) 555-3514"]},{"name":"John Appleseed","phone_numbers":["888-555-5512","888-555-1212"]},{"name":"Anna Haro","phone_numbers":["555-522-8243"]},{"name":"Hank M. Zakroff","phone_numbers":["(555) 766-4823","(707) 555-1854"]},{"name":"David Taylor","phone_numbers":["555-610-6679"]}]

    request.headers[:user] = create(:user).id
    get :import, params: { contacts: data }

    expect(response.status).to eq(200)
    expect(Contact.count).to eq(11)
  end
end
