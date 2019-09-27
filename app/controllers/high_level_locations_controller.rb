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
      params.require(:high_level_location).permit(:name, :zip, :long, :lat)
    end
end
