class GenusController < ApplicationController
  before_action :set_genu, only: [:show, :edit, :update, :destroy]

  # GET /genus
  # GET /genus.json
  def index
    @genus = Genu.all
  end

  # GET /genus/1
  # GET /genus/1.json
  def show
  end

  # GET /genus/new
  def new
    @genu = Genu.new
  end

  # GET /genus/1/edit
  def edit
  end

  # POST /genus
  # POST /genus.json
  def create
    @genu = Genu.new(genu_params)

    respond_to do |format|
      if @genu.save
        format.html { redirect_to @genu, notice: 'Genu was successfully created.' }
        format.json { render :show, status: :created, location: @genu }
      else
        format.html { render :new }
        format.json { render json: @genu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genus/1
  # PATCH/PUT /genus/1.json
  def update
    respond_to do |format|
      if @genu.update(genu_params)
        format.html { redirect_to @genu, notice: 'Genu was successfully updated.' }
        format.json { render :show, status: :ok, location: @genu }
      else
        format.html { render :edit }
        format.json { render json: @genu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genus/1
  # DELETE /genus/1.json
  def destroy
    @genu.destroy
    respond_to do |format|
      format.html { redirect_to genus_url, notice: 'Genu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genu
      @genu = Genu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genu_params
      params.require(:genu).permit(:name, :description)
    end
end
