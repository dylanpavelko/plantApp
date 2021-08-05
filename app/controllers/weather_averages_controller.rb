class WeatherAveragesController < ApplicationController
  before_action :set_weather_average, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /weather_averages
  # GET /weather_averages.json
  def index
    @weather_averages = WeatherAverage.all
  end

  # GET /weather_averages/1
  # GET /weather_averages/1.json
  def show
  end

  # GET /weather_averages/new
  def new
    @weather_average = WeatherAverage.new
  end

  # GET /weather_averages/1/edit
  def edit
  end

  # POST /weather_averages
  # POST /weather_averages.json
  def create
    @weather_average = WeatherAverage.new(weather_average_params)

    respond_to do |format|
      if @weather_average.save
        format.html { redirect_to @weather_average, notice: 'Weather average was successfully created.' }
        format.json { render :show, status: :created, location: @weather_average }
      else
        format.html { render :new }
        format.json { render json: @weather_average.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_averages/1
  # PATCH/PUT /weather_averages/1.json
  def update
    respond_to do |format|
      if @weather_average.update(weather_average_params)
        format.html { redirect_to @weather_average, notice: 'Weather average was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_average }
      else
        format.html { render :edit }
        format.json { render json: @weather_average.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_averages/1
  # DELETE /weather_averages/1.json
  def destroy
    @weather_average.destroy
    respond_to do |format|
      format.html { redirect_to weather_averages_url, notice: 'Weather average was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_average
      @weather_average = WeatherAverage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather_average_params
      params.require(:weather_average).permit(:day, :high_level_location_id, :max_temp_f, :min_temp_f, :precip_in, :max_t_std_dev, :min_t_std_dev, :precip_std_dev)
    end
end
