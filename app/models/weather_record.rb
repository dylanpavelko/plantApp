class WeatherRecord < ApplicationRecord
  belongs_to :high_level_location
  
  @forecast = ""
  
    def get_attributes
        return ActiveSupport::JSON.decode(self.report)["daily"]["data"][0]
    end
    
    def get_attribute(attribute)
        return ActiveSupport::JSON.decode(self.report)["daily"]["data"][0][attribute]
    end
    
    def summary
        self.get_attribute("summary")
    end
    
    def temperatureMax
        self.get_attribute("temperatureMax")
    end
    
    def temperatureLow
        self.get_attribute("temperatureLow")
    end
    
    def ozone
        self.get_attribute("ozone")
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
