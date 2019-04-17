# !
class Api::V1::ContactsController < Api::V1::BaseController

  def import
    contact_params = params.require(:contacts)

    if contact_params.count > 0

      Contact.where(user: current_user).delete_all

      contact_params.each do |contact|
        contact.permit(:name, phone_numbers: [])

        contact[:phone_numbers].each do |phone_number|
          phone_number = phone_number_checked(phone_number, %i[fr us uk de])

          next unless phone_number.present?

          Contact.where(user: current_user, phone_number: phone_number).first_or_create(name: contact[:name])
        end
      end
    end

    render json: true
  end

  private

  def phone_number_checked(phone_number, countries)
    phone = nil

    countries.each do |country|
      break if phone.present?

      phone = phone_number_country(phone_number, country)
    end

    return phone
  end

  def phone_number_country(phone_number, country)
    check = Phonelib.parse(phone_number, country)

    return check.e164 if check.valid?

    return nil
  end
end
