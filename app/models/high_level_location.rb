class HighLevelLocation < ApplicationRecord
    require "open-uri"
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    has_many :locations, :class_name => "Location", :foreign_key => "high_level_location_id"

    @forecast = ""
    
    def set_forecast
        @url = "https://api.darksky.net/forecast/" + Figaro.env.dark_sky_key + "/" + self.lat.to_s + "," + self.long.to_s
        @forecast = URI.parse(@url).read
        @forecast = ActiveSupport::JSON.decode(@forecast)
    end
    
    def get_full_forecast
        return @forecast
    end
    
    def get_current_time
        return Time.at(@forecast["currently"]["time"]).in_time_zone(@forecast["timezone"])
    end
    
    def get_current_time_formatted
        return self.get_current_time.strftime("%m/%d/%Y at %I:%M%p")
    end
    
    def get_current_temp
        @forecast["currently"]["temperature"]
    end
    
    def get_forecast_days
        @forecast["daily"]["data"]
    end
    
    def get_simple_date(time)
        return Time.at(time).in_time_zone(@forecast["timezone"]).strftime("%a %-m/%d")
    end
    
    def get_weather_icon(icon)
        image_path = ""
        if icon == "clear-day"
            image_path = "https://icon-library.net/images/sunny-icon-png/sunny-icon-png-23.jpg"
        elsif icon == "partly-cloudy-day"
            image_path = "https://icon-library.net/images/partly-cloudy-icon/partly-cloudy-icon-28.jpg"
        elsif icon == "rain"
            image_path = "https://icon-library.net/images/rain-icon/rain-icon-27.jpg"
        end
        return image_path
            
    end

    def get_noaa_ncdc_data
        base_url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/"
        top = self.long - 0.1
        bottom = self.long + 0.1
        right = self.lat - 0.1
        left = self.lat + 0.1
        @extent = "extent="+right.to_s+","+top.to_s+","+left.to_s+","+bottom.to_s
        @data = URI.open(base_url + "stations?"+@extent + "&limit=100&datatypeid=TMAX&datatypeid=TMIN","token"=>Figaro.env.noaa_ncdc_token).read
        return ActiveSupport::JSON.decode(@data)
    end

    def get_datasets_for_noaa_station(station_id)
        base_url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/"
        @station = "stationid="+station_id
        @data = URI.open(base_url + "datasets?"+@station,"token"=>Figaro.env.noaa_ncdc_token).read
        return ActiveSupport::JSON.decode(@data)
    end

    def get_weather_for_noaa_station_for_dates(station_id, start_date, end_date)
        base_url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/"
        @station = "&stationid="+station_id
        @start_date = start_date
        @end_date = end_date
        @date_range = "&startdate=" + @start_date + "&enddate=" + @end_date
        @data_types = "&datatypeid=PRCP,TMAX,TMIN"
        @data = URI.open(base_url + "data?datasetid=GHCND" + @station + @date_range + @data_types + "&units=standard&limit=1000" ,"token"=>Figaro.env.noaa_ncdc_token).read
        return ActiveSupport::JSON.decode(@data)
    end
end
