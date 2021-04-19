class HighLevelLocationsController < ApplicationController
  before_action :set_high_level_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  
  # GET /high_level_locations
  # GET /high_level_locations.json
  def index
    @high_level_locations = HighLevelLocation.all
  end

  # GET /high_level_locations/1
  # GET /high_level_locations/1.json
  def show
    @locations = Location.where(:high_level_location_id => @high_level_location.id)
    @today = DateTime.now
    @yesterday = @today - 1
    @yearAgo = @today - 365
    @next_90_days = Array.new

    #get weather records for location sorted by date
    @wrs = WeatherRecord.where(:high_level_location_id => @high_level_location.id).sort_by &:date
    #get yesterdays date

    #get weather stations
    @operating_stations = Array.new
    @stations = @high_level_location.get_noaa_ncdc_data['results']
    @stations.each do |r| 
      if DateTime.parse(r['maxdate']) > @yearAgo
        distance = ((r['longitude'] - @high_level_location.long)**2 + (r['latitude'] - @high_level_location.lat)**2)
        @operating_stations << [r, distance]
      end
    end
    @operating_stations = @operating_stations.sort {|a,b| a[1] <=> b[1]} 





    @weather_records = Hash.new
    @max_temp_data = Array.new
    @min_temp_data = Array.new
    @date_labels = Array.new

    station_number = 0
    while (@max_temp_data.size < 365 || @min_temp_data.size < 365) && station_number < @operating_stations.size
      #puts "station number: " + station_number.to_s
      #puts "max_temp_size: " + max_temp_data.size.to_s
      #puts "min_temp_size: " + min_temp_data.size.to_s
      station = @operating_stations[station_number][0]['id']
      @weather_results = @high_level_location.get_weather_for_noaa_station_for_dates(station.to_s, "2020-01-01", "2020-06-30")['results']
      if @weather_results != nil
      @weather_results.each_with_index do |r, i|
      #puts r.inspect
        if @weather_records.key?(r['date'])
          @weather_records[r['date']][r['datatype']] = r['value']
        else
          @weather_records[r['date']] = Hash.new
          @weather_records[r['date']][r['datatype']] = r['value']
          @date_labels << DateTime.parse(r['date']).strftime("%m/%d")
        end
        if r['datatype'] == "TMAX"
          @max_temp_data << r['value']
        elsif r['datatype'] == "TMIN"
          @min_temp_data << r['value']
        end
      end
      
      @high_level_location.get_weather_for_noaa_station_for_dates(station, "2020-07-01", "2020-12-31")['results'].each_with_index do |r, i|
        if @weather_records.key?(r['date'])
          @weather_records[r['date']][r['datatype']] = r['value']
        else
          @weather_records[r['date']] = Hash.new
          @weather_records[r['date']][r['datatype']] = r['value']
          @date_labels << DateTime.parse(r['date']).strftime("%m/%d")
        end
        if r['datatype'] == "TMAX"
          @max_temp_data << r['value']
        elsif r['datatype'] == "TMIN"
          @min_temp_data << r['value']
        end
      end
      
    end
    station_number = station_number + 1
  end





  puts "how many weather records"

  if @wrs.size > 0
    #get the latest date recorded
    @latest = @wrs.last
    @latest_date = @latest.date
    while @latest_date != @yesterday
      if @latest_date > @yesterday-182
        get_and_save_noaa(@high_level_location, station, (@latest_date+1), @yesterday)
        @latest_date = @yesterday
      else
        get_and_save_noaa(@high_level_location, station, (@latest_date+1), (@latest_date+182))
        @latest_date = @latest_date + 182
      end
    end

    #get the earliest date recorded
    #while earliest > yesterday - 5 years
      #get noaa weather for earliest - 6 months to earliest
      #update earliest date
  else
    get_and_save_noaa(@high_level_location, station, (@yesterday-182), @yesterday)
  end

    @years = Array.new
    (1..5).each do |index|
      @start_date = @today + 7 - (365 * index)
      @end_date = @today + 7 + 90 - (365 * index)
      @years.push(WeatherRecord.where(:date => @start_date..@end_date, :high_level_location_id => @high_level_location.id).sort_by &:date)
    end

  end

  # GET /high_level_locations/new
  def new
    @high_level_location = HighLevelLocation.new
  end

  # GET /high_level_locations/1/edit
  def edit
  end

  # POST /high_level_locations
  # POST /high_level_locations.json
  def create
    @high_level_location = HighLevelLocation.new(high_level_location_params)

    respond_to do |format|
      if @high_level_location.save
        format.html { redirect_to @high_level_location, notice: 'High level location was successfully created.' }
        format.json { render :show, status: :created, location: @high_level_location }
      else
        format.html { render :new }
        format.json { render json: @high_level_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /high_level_locations/1
  # PATCH/PUT /high_level_locations/1.json
  def update
    respond_to do |format|
      if @high_level_location.update(high_level_location_params)
        format.html { redirect_to @high_level_location, notice: 'High level location was successfully updated.' }
        format.json { render :show, status: :ok, location: @high_level_location }
      else
        format.html { render :edit }
        format.json { render json: @high_level_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /high_level_locations/1
  # DELETE /high_level_locations/1.json
  def destroy
    @high_level_location.destroy
    respond_to do |format|
      format.html { redirect_to high_level_locations_url, notice: 'High level location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_high_level_location
      @high_level_location = HighLevelLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def high_level_location_params
      params.require(:high_level_location).permit(:name, :zip, :long, :lat, :user_id)
    end


    def get_and_save_noaa(high_level_location, station, from_date, to_date)
      @new_records = Hash.new
      @results = high_level_location.get_weather_for_noaa_station_for_dates(station, from_date.strftime("%Y-%m-%d"), to_date.strftime("%Y-%m-%d"))['results']
      if @results != nil
        @results.each_with_index do |r, i|
          if @new_records.key?(r['date'])
            @new_records[r['date']][r['datatype']] = r['value']
          else
            @new_records[r['date']] = Hash.new
            @new_records[r['date']][r['datatype']] = r['value']
          end
        end
        @new_records.each do |r|
          @nwr = WeatherRecord.new(:high_level_location_id => high_level_location.id, :date => r[0], :min_temp_f => r[1]['TMIN'], :max_temp_f => r[1]['TMAX'], :precip_in => r[1]['PRCP'])
          @nwr.save
          set_average_for_location_on_date(high_level_location, r[0])
        end
      end
    end

    def set_average_for_location_on_date(high_level_location, date)
      @day_of_year = DateTime.parse(date).to_date.yday
      #@days = WeatherRecord.where("EXTRACT(DOY FROM DATE) is ?", @day_of_year)
      #@days = WeatherRecord.where("high_level_location_id = ? AND strftime('%j', date) is ?", high_level_location.id, @day_of_year)
      #need to support this differently for sqlite vs pg see https://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field for PG
      @days = WeatherRecord.where("high_level_location_id = ? AND cast(strftime('%j',date) as int) = ?", high_level_location.id, @day_of_year)
      puts "number of days for " + @day_of_year.to_s
      days = @days.count
      puts days
      avg_max = @days.average(:max_temp_f)
      avg_min = @days.average(:min_temp_f)
      avg_precip = @days.average(:precip_in)

      max_deviation = 0
      min_deviation = 0
      precip_deviation = 0

      @days.each do |day|
        max_deviation += (day.max_temp_f - avg_max)**2
        min_deviation += (day.min_temp_f - avg_min)**2
        precip_deviation += (day.precip_in - avg_precip)**2
      end

      max_std_dev = (max_deviation/days)**(1/2)
      min_std_dev = (min_deviation/days)**(1/2)
      precip_std_dev = (precip_deviation/days)**(1/2)

      @average = WeatherAverage.where(:high_level_location => high_level_location, :day => @day_of_year)
      if @average.count > 0
        @average.update(:max_temp_f => avg_max, :min_temp_f => avg_min, :avg_precip => avg_precip, :max_t_std_dev => max_deviation, :min_t_std_dev => min_deviation, :precip_std_dev => precip_deviation)
      else
        @average = WeatherAverage.new(:high_level_location => high_level_location, :day => @day_of_year, :max_temp_f => avg_max, :min_temp_f => avg_min, :precip_in => avg_precip, :max_t_std_dev => max_deviation, :min_t_std_dev => min_deviation, :precip_std_dev => precip_deviation)
        @average.save
      end
    end
end
