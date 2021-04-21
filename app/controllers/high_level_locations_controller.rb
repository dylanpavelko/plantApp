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
    @weather_records = WeatherRecord.where(:high_level_location_id => @high_level_location.id).sort_by &:date
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


    @averages = WeatherAverage.where(:high_level_location => @high_level_location).sort_by &:day




  #   @weather_records = Hash.new
    @max_temp_data = Array.new
    @min_temp_data = Array.new
    @min_deviation_data = Array.new
    @max_deviation_data = Array.new
    @date_labels = Array.new
    @precip_data = Array.new


    @averages.each do |ad|
      @date_labels << ((Date.new(y=2020, m=12, d=31) + ad.day).strftime("%m/%d"))
      @max_temp_data << ad.max_temp_f
      @min_temp_data << ad.min_temp_f
      @precip_data << ad.precip_in
      @max_deviation_data << ad.max_temp_f + ad.max_t_std_dev
      @min_deviation_data << ad.min_temp_f - ad.min_t_std_dev

    end

  #   station_number = 0
  #   while (@max_temp_data.size < 365 || @min_temp_data.size < 365) && station_number < @operating_stations.size
  #     #puts "station number: " + station_number.to_s
  #     #puts "max_temp_size: " + max_temp_data.size.to_s
  #     #puts "min_temp_size: " + min_temp_data.size.to_s
  #     station = @operating_stations[station_number][0]['id']
  #     @weather_results = @high_level_location.get_weather_for_noaa_station_for_dates(station.to_s, "2020-01-01", "2020-06-30")['results']
  #     if @weather_results != nil
  #     @weather_results.each_with_index do |r, i|
  #     #puts r.inspect
  #       if @weather_records.key?(r['date'])
  #         @weather_records[r['date']][r['datatype']] = r['value']
  #       else
  #         @weather_records[r['date']] = Hash.new
  #         @weather_records[r['date']][r['datatype']] = r['value']
  #         @date_labels << DateTime.parse(r['date']).strftime("%m/%d")
  #       end
  #       if r['datatype'] == "TMAX"
  #         @max_temp_data << r['value']
  #       elsif r['datatype'] == "TMIN"
  #         @min_temp_data << r['value']
  #       end
  #     end
      
  #     @high_level_location.get_weather_for_noaa_station_for_dates(station, "2020-07-01", "2020-12-31")['results'].each_with_index do |r, i|
  #       if @weather_records.key?(r['date'])
  #         @weather_records[r['date']][r['datatype']] = r['value']
  #       else
  #         @weather_records[r['date']] = Hash.new
  #         @weather_records[r['date']][r['datatype']] = r['value']
  #         @date_labels << DateTime.parse(r['date']).strftime("%m/%d")
  #       end
  #       if r['datatype'] == "TMAX"
  #         @max_temp_data << r['value']
  #       elsif r['datatype'] == "TMIN"
  #         @min_temp_data << r['value']
  #       end
  #     end
      
  #   end
  #   station_number = station_number + 1
  # end
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


   
end
