class Requester
    def self.send (adress, exeptions)
       response = HTTParty.get URI.encode("#{API_REQUEST}geocode=#{adress}")
       respon_json = response.parsed_response
       begin
        respon_json["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"]
       rescue NoMethodError
        exeptions << adress
       end
    end
end