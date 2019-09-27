class HighLevelLocation < ApplicationRecord
    require "open-uri"

    @forecast = ""
    
    def set_forecast
        @url = "https://api.darksky.net/forecast/" + Figaro.env.dark_sky_key + "/" + self.lat.to_s + "," + self.long.to_s
        puts @url
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
end
