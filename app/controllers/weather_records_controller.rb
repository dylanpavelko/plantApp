class WeatherRecordsController < ApplicationController
  before_action :set_weather_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /weather_records
  # GET /weather_records.json
  def index
    @weather_records = WeatherRecord.all
  end

  # GET /weather_records/1
  # GET /weather_records/1.json
  def show
  end

  # GET /weather_records/new
  def new
   
    @date = Time.at(params[:date].to_i)
    @high_level_location = HighLevelLocation.find(params[:high_level_location_id])
    @lat = @high_level_location.lat
    @long = @high_level_location.long
    @forecast = nil
    if(@date != nil and @lat != nil and @long != nil)
      @location_url = @lat.to_s + "," + @long.to_s + "," + params[:date]
      @url = "https://api.darksky.net/forecast/" + Figaro.env.dark_sky_key + "/" + @location_url
      puts @url
      @forecast = URI.parse(@url).read
      #@forecast = ActiveSupport::JSON.decode(@forecast)
    end
     @weather_record = WeatherRecord.new(:high_level_location_id => params[:high_level_location_id], :report => @forecast, :date => @date)
  end

  # GET /weather_records/1/edit
  def edit
    @date = @weather_record.date
  end

  # POST /weather_records
  # POST /weather_records.json
  def create
    @weather_record = WeatherRecord.new(weather_record_params)

    respond_to do |format|
      if @weather_record.save
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully created.' }
        format.json { render :show, status: :created, location: @weather_record }
      else
        format.html { render :new }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_records/1
  # PATCH/PUT /weather_records/1.json
  def update
    respond_to do |format|
      if @weather_record.update(weather_record_params)
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_record }
      else
        format.html { render :edit }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_records/1
  # DELETE /weather_records/1.json
  def destroy
    @weather_record.destroy
    respond_to do |format|
      format.html { redirect_to weather_records_url, notice: 'Weather record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def get_new_weather_records
    puts "AJAX SUCCESS"
    high_level_location_id = params[:high_level_location_id]
    station_list = params[:station_list]
    @today = DateTime.now
    @yesterday = @today - 1
    @yearAgo = @today - 365

    @high_level_location = HighLevelLocation.find(high_level_location_id)
    @wrs = WeatherRecord.where(:high_level_location_id => high_level_location_id).sort_by &:date

    station = station_list[0]

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
      @earliest = @wrs.first
      @earliest_date =  @earliest.date
      while @earliest_date > @yesterday - (5 *365)
        #get noaa weather for earliest - 6 months to earliest
        get_and_save_noaa(@high_level_location, station, (@earliest_date - 183), (@earliest_date - 1))
        #update earliest date
        @earliest_date = @earliest_date - 183
      end
    else
      get_and_save_noaa(@high_level_location, station, (@yesterday-182), @yesterday)
    end

    redirect_to @high_level_location

    return true

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_record
      @weather_record = WeatherRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_record_params
      params.require(:weather_record).permit(:date, :report, :high_level_location_id, :lat, :long)
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
      return @results
    end

    def set_average_for_location_on_date(high_level_location, date)
      @day_of_year = DateTime.parse(date).to_date.yday
      #@days = WeatherRecord.where("EXTRACT(DOY FROM DATE) is ?", @day_of_year)
      #@days = WeatherRecord.where("high_level_location_id = ? AND strftime('%j', date) is ?", high_level_location.id, @day_of_year)
      #need to support this differently for sqlite vs pg see https://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field for PG
      if Rails.env.development?
        @days = WeatherRecord.where("high_level_location_id = ? AND cast(strftime('%j',date) as int) = ?", high_level_location.id, @day_of_year)
      else
        @days = WeatherRecord.where("high_level_location_id = ? AND extract(doy from date) = ?", high_level_location.id, @day_of_year)
      end
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
        puts day.inspect
        if day != nil
          max_deviation += (day.max_temp_f - avg_max)**2
          min_deviation += (day.min_temp_f - avg_min)**2
          precip_deviation += (day.precip_in - avg_precip)**2
        end
      end

      puts "min dev"
      puts (min_deviation/days)

      max_std_dev = (max_deviation/days)**(0.5)
      min_std_dev = (min_deviation/days)**(0.5)
      precip_std_dev = (precip_deviation/days)**(0.5)

      puts "min std dev"
      puts min_std_dev

      @average = WeatherAverage.where(:high_level_location => high_level_location, :day => @day_of_year)
      if @average.count > 0
        @average.update(:max_temp_f => avg_max, :min_temp_f => avg_min, :precip_in => avg_precip, 
                        :max_t_std_dev => max_std_dev, :min_t_std_dev => min_std_dev, :precip_std_dev => precip_std_dev)
      else
        @average = WeatherAverage.new(:high_level_location => high_level_location, :day => @day_of_year, 
                                      :max_temp_f => avg_max, :min_temp_f => avg_min, :precip_in => avg_precip, 
                                      :max_t_std_dev => max_std_dev, :min_t_std_dev => min_std_dev, :precip_std_dev => precip_std_dev)
        @average.save
      end
    end
end
