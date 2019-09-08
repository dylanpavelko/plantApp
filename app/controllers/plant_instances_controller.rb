class PlantInstancesController < ApplicationController
  before_action :authenticate_user_admin  #make this not be admin only
  before_action :set_plant_instance, only: [:show, :edit, :update, :destroy]

  # GET /plant_instances
  # GET /plant_instances.json
  def index
    @plant_instances = PlantInstance.all
  end

  # GET /plant_instances/1
  # GET /plant_instances/1.json
  def show
    @water_records = WaterRecord.where(:plant_instance_id => @plant_instance.id)
  end

  # GET /plant_instances/new
  def new
    @plant_instance = PlantInstance.new
  end

  # GET /plant_instances/1/edit
  def edit
  end

  # POST /plant_instances
  # POST /plant_instances.json
  def create
    @plant_instance = PlantInstance.new(plant_instance_params)

    respond_to do |format|
      if @plant_instance.save
        format.html { redirect_to @plant_instance, notice: 'Plant instance was successfully created.' }
        format.json { render :show, status: :created, location: @plant_instance }
      else
        format.html { render :new }
        format.json { render json: @plant_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plant_instances/1
  # PATCH/PUT /plant_instances/1.json
  def update
    respond_to do |format|
      if @plant_instance.update(plant_instance_params)
        format.html { redirect_to @plant_instance, notice: 'Plant instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @plant_instance }
      else
        format.html { render :edit }
        format.json { render json: @plant_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plant_instances/1
  # DELETE /plant_instances/1.json
  def destroy
    @plant_instance.destroy
    respond_to do |format|
      format.html { redirect_to plant_instances_url, notice: 'Plant instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant_instance
      @plant_instance = PlantInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plant_instance_params
      params.require(:plant_instance).permit(:plant_id, :location_id, :planted_date, :acquired_date, :propagation_type)
    end
end
