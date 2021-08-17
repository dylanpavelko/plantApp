class BbchStagesController < ApplicationController
  before_action :set_bbch_stage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /bbch_stages
  # GET /bbch_stages.json
  def index
    @bbch_stages = BbchStage.all
  end

  # GET /bbch_stages/1
  # GET /bbch_stages/1.json
  def show
  end

  # GET /bbch_stages/new
  def new
    
    @bbch_stage = BbchStage.new(:bbch_profile_id => params[:bbch_profile])
  end

  # GET /bbch_stages/1/edit
  def edit
  end

  # POST /bbch_stages
  # POST /bbch_stages.json
  def create
    @bbch_stage = BbchStage.new(bbch_stage_params)

    respond_to do |format|
      if @bbch_stage.save
        format.html { redirect_to @bbch_stage.bbch_profile, notice: 'Bbch stage was successfully created.' }
        format.json { render :show, status: :created, location: @bbch_stage }
      else
        format.html { render :new }
        format.json { render json: @bbch_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bbch_stages/1
  # PATCH/PUT /bbch_stages/1.json
  def update
    respond_to do |format|
      if @bbch_stage.update(bbch_stage_params)
        format.html { redirect_to @bbch_stage, notice: 'Bbch stage was successfully updated.' }
        format.json { render :show, status: :ok, location: @bbch_stage }
      else
        format.html { render :edit }
        format.json { render json: @bbch_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbch_stages/1
  # DELETE /bbch_stages/1.json
  def destroy
    @bbch_stage.destroy
    respond_to do |format|
      format.html { redirect_to bbch_stages_url, notice: 'Bbch stage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bbch_stage
      @bbch_stage = BbchStage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bbch_stage_params
      params.require(:bbch_stage).permit(:code, :description, :note, :bbch_profile_id)
    end
end
