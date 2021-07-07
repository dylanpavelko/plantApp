class GrowthObservationsController < ApplicationController
  before_action :set_growth_observation, only: [:show, :edit, :update, :destroy]

  # GET /growth_observations
  # GET /growth_observations.json
  def index
    @growth_observations = GrowthObservation.all
  end

  # GET /growth_observations/1
  # GET /growth_observations/1.json
  def show
  end

  # GET /growth_observations/new
  def new
    @growth_observation = GrowthObservation.new(:plant_instance_id => params[:plant_instance_id])
    @growth_stages = BbchStage.where(:bbch_profile_id => @growth_observation.plant_instance.plant.species.bbch_profile_id).sort_by{|e| e[:code]}
  end

  # GET /growth_observations/1/edit
  def edit
    @growth_stages = BbchStage.where(:bbch_profile_id => @growth_observation.plant_instance.plant.species.bbch_profile_id).sort_by{|e| e[:code]}
  end

  # POST /growth_observations
  # POST /growth_observations.json
  def create
    @growth_observation = GrowthObservation.new(growth_observation_params)
    @growth_stages = BbchStage.where(:bbch_profile_id => @growth_observation.plant_instance.plant.species.bbch_profile_id).sort_by{|e| e[:code]}


    respond_to do |format|
      if @growth_observation.save
        format.html { redirect_to @growth_observation.plant_instance, notice: 'Growth observation was successfully created.' }
        format.json { render :show, status: :created, location: @growth_observation }
      else
        format.html { render :new }
        format.json { render json: @growth_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /growth_observations/1
  # PATCH/PUT /growth_observations/1.json
  def update
    respond_to do |format|
      if @growth_observation.update(growth_observation_params)
        format.html { redirect_to @growth_observation.plant_instance, notice: 'Growth observation was successfully updated.' }
        format.json { render :show, status: :ok, location: @growth_observation }
      else
        format.html { render :edit }
        format.json { render json: @growth_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /growth_observations/1
  # DELETE /growth_observations/1.json
  def destroy
    @growth_observation.destroy
    respond_to do |format|
      format.html { redirect_to growth_observations_url, notice: 'Growth observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_growth_observation
      @growth_observation = GrowthObservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def growth_observation_params
      params.require(:growth_observation).permit(:plant_instance_id, :observation_date, :bbch_stage_id, :percent_at_stage, :picture)
    end
end
