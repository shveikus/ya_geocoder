module GeoJSONBuilder
    def self.build_geojson(arr)
        @geo_factory = RGeo::Cartesian.simple_factory(srid: 4326)
        @entity_factory = RGeo::GeoJSON::EntityFactory.instance
        arr_of_instances = arr.map do |coordinates|
            ll = coordinates[0].to_f
            ld = coordinates[1].to_f
            color = coordinates[2]
            description = coordinates[3]
            @entity_factory.feature(@geo_factory.point(ll, ld), nil, "marker-color":"#{color}", "description":"#{description}")
        end
        object = @entity_factory.feature_collection(arr_of_instances)
        RGeo::GeoJSON.encode(object)
    end
end