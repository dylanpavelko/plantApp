class WaterRecordsController < ApplicationController
  before_action :set_water_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /water_records
  # GET /water_records.json
  def index
    @water_records = WaterRecord.all
  end

  # GET /water_records/1
  # GET /water_records/1.json
  def show
  end

  # GET /water_records/new
  def new
    @local_moment = DateTime.now.in_time_zone('Pacific Time (US & Canada)')
    @water_record = WaterRecord.new()
    @plant_instance = PlantInstance.find(params[:plant_instance_id])
  end

  # GET /water_records/1/edit
  def edit
    @local_moment = DateTime.now.in_time_zone('Pacific Time (US & Canada)')
    @plant_instance = @water_record.plant_instance
  end

  # POST /water_records
  # POST /water_records.json
  def create
    @water_record = WaterRecord.new(water_record_params)

    respond_to do |format|
      if @water_record.save
        format.html { redirect_to @water_record.plant_instance, notice: 'Water record was successfully created.' }
        format.json { render :show, status: :created, location: @water_record }
      else
        format.html { render :new }
        format.json { render json: @water_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /water_records/1
  # PATCH/PUT /water_records/1.json
  def update
    respond_to do |format|
      if @water_record.update(water_record_params)
        format.html { redirect_to @water_record.plant_instance, notice: 'Water record was successfully updated.' }
        format.json { render :show, status: :ok, location: @water_record }
      else
        format.html { render :edit }
        format.json { render json: @water_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /water_records/1
  # DELETE /water_records/1.json
  def destroy
    @water_record.destroy
    respond_to do |format|
      format.html { redirect_to water_records_url, notice: 'Water record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_water_record
      @water_record = WaterRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def water_record_params
      params.require(:water_record).permit(:plant_instance_id, :moment, :ounces)
    end
end
