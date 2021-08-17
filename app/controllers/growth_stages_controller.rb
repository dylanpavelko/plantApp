class GrowthStagesController < ApplicationController
  before_action :set_growth_stage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /growth_stages
  # GET /growth_stages.json
  def index
    @growth_stages = GrowthStage.all
  end

  # GET /growth_stages/1
  # GET /growth_stages/1.json
  def show
  end

  # GET /growth_stages/new
  def new
    @growth_stage = GrowthStage.new(:species_id => params[:species_id], :bbch_code => params[:bbch_code])
    @species = Species.find(params[:species_id])
  end

  # GET /growth_stages/1/edit
  def edit
  end

  # POST /growth_stages
  # POST /growth_stages.json
  def create
    @growth_stage = GrowthStage.new(growth_stage_params)

    respond_to do |format|
      if @growth_stage.save
        format.html { redirect_to @growth_stage, notice: 'Growth stage was successfully created.' }
        format.json { render :show, status: :created, location: @growth_stage }
      else
        format.html { render :new }
        format.json { render json: @growth_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /growth_stages/1
  # PATCH/PUT /growth_stages/1.json
  def update
    respond_to do |format|
      if @growth_stage.update(growth_stage_params)
        format.html { redirect_to @growth_stage, notice: 'Growth stage was successfully updated.' }
        format.json { render :show, status: :ok, location: @growth_stage }
      else
        format.html { render :edit }
        format.json { render json: @growth_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /growth_stages/1
  # DELETE /growth_stages/1.json
  def destroy
    @growth_stage.destroy
    respond_to do |format|
      format.html { redirect_to growth_stages_url, notice: 'Growth stage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_growth_stage
      @growth_stage = GrowthStage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def growth_stage_params
      params.require(:growth_stage).permit(:species_id, :bbch_code, :cold_damage_risk, :required_low, :growth_base, :required_high, :growth_cutoff, :heat_damage_risk, :min_days, :min_agdd, :from_bbch_code, :harvestable)
    end
end
