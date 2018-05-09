#
class GeoLib
  # def self.googlemap_image(address: nil, latitude: nil, longitude: nil, width: 600, height: 300)
  #   if latitude && longitude
  #     "https://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&markers=color:green|#{latitude},#{longitude}&zoom=13&size=#{width}x#{height}&maptype=roadmap&key=#{Rails.application.secrets.googlemap_api_key}"
  #   elsif address
  #     "https://maps.googleapis.com/maps/api/staticmap?center=#{address}&zoom=13&size=#{width}x#{height}&maptype=roadmap&key=#{Rails.application.secrets.googlemap_api_key}"
  #   end
  # end

  # def self.get_countries(codes)
  #   data = {}
  #   countries = []
  #   codes.compact.map do |code|
  #     data[get_country(code)] = code.to_sym
  #   end

  #   data.sort.each do |name, code|
  #     countries.push(ref: code, name: name)
  #   end

  #   countries
  # end

  def self.get_country(code)
    return nil unless code
    case code.to_sym
    when :GB then
      'United Kingdom'
    when :US then
      'United States'
    else
      ISO3166::Country[code.to_sym].name
    end
  end
end
