class BbchProfilesController < ApplicationController
  before_action :set_bbch_profile, only: [:show, :edit, :update, :destroy]

  # GET /bbch_profiles
  # GET /bbch_profiles.json
  def index
    @bbch_profiles = BbchProfile.all
  end

  # GET /bbch_profiles/1
  # GET /bbch_profiles/1.json
  def show
    @stages = BbchStage.where(:bbch_profile => @bbch_profile).sort_by{|e| e[:code]}
  end

  # GET /bbch_profiles/new
  def new
    @bbch_profile = BbchProfile.new
  end

  # GET /bbch_profiles/1/edit
  def edit
  end

  # POST /bbch_profiles
  # POST /bbch_profiles.json
  def create
    @bbch_profile = BbchProfile.new(bbch_profile_params)

    respond_to do |format|
      if @bbch_profile.save
        format.html { redirect_to @bbch_profile, notice: 'Bbch profile was successfully created.' }
        format.json { render :show, status: :created, location: @bbch_profile }
      else
        format.html { render :new }
        format.json { render json: @bbch_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bbch_profiles/1
  # PATCH/PUT /bbch_profiles/1.json
  def update
    respond_to do |format|
      if @bbch_profile.update(bbch_profile_params)
        format.html { redirect_to @bbch_profile, notice: 'Bbch profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @bbch_profile }
      else
        format.html { render :edit }
        format.json { render json: @bbch_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbch_profiles/1
  # DELETE /bbch_profiles/1.json
  def destroy
    @bbch_profile.destroy
    respond_to do |format|
      format.html { redirect_to bbch_profiles_url, notice: 'Bbch profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bbch_profile
      @bbch_profile = BbchProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bbch_profile_params
      params.require(:bbch_profile).permit(:name)
    end
end
