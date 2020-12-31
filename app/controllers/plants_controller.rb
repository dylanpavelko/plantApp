class PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_user, only: [:show]

  # GET /plants
  # GET /plants.json
  def index
    @plants = Plant.all
    @allPlants = @plants
    @order_categories = Array.new
    @plants = Array.new
    @species = Array.new
    @genuses = Array.new
    @families = Array.new
    
    @orders = Order.all
    @orders.each do |o|
      @families = Array.new
      @o_families = Family.where(:order_id => o.id)
      @o_families.each do |of|
        @genuses = Array.new
        @of_genuses = Genu.where(:family_id => of.id)
        @of_genuses.each do |ofg|
          @species = Array.new
          @ofg_species = Species.where(:genus_id => ofg.id)
          @ofg_species.each do |ofgs|
            @plants = Plant.where(:species_id => ofgs.id)
            @species << [ofgs, @plants]
          end
          @genuses << [ofg, @species]
        end
        @families << [of, @genuses]
      end
      @order_categories << [o, @families]
    end
  end

  # GET /plants/1
  # GET /plants/1.json
  def show
    @common_names = CommonName.where(:plant_id => @plant.id)
    if @current_user != nil 
      @wishlist = Wishlist.where(:plant_id => @plant.id, :user_id => @current_user.id)
      if @wishlist.count > 0
        @on_wishlist = true
      else
        @on_wishlist = false
      end
    end

    @has_open_farm_data = false
    if @plant.OpenFarmID != nil and @plant.OpenFarmID != ""
      @open_farm_data = get_open_farm_data(@plant.OpenFarmID)
      @has_open_farm_data = true
    end

    @potential_matches = get_potential_open_farm_matches(@plant.scientific_name)
  end

  # GET /plants/new
  def new
    @plant = Plant.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants
  # POST /plants.json
  def create
    @plant = Plant.new(plant_params)

    respond_to do |format|
      if @plant.save
        format.html { redirect_to @plant, notice: 'Plant was successfully created.' }
        format.json { render :show, status: :created, location: @plant }
      else
        format.html { render :new }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plants/1
  # PATCH/PUT /plants/1.json
  def update
    respond_to do |format|
      if @plant.update(plant_params)
        format.html { redirect_to @plant, notice: 'Plant was successfully updated.' }
        format.json { render :show, status: :ok, location: @plant }
      else
        format.html { render :edit }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1
  # DELETE /plants/1.json
  def destroy
    @plant.destroy
    respond_to do |format|
      format.html { redirect_to plants_url, notice: 'Plant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_open_farm_data(id)
    response = Excon.get('https://openfarm.cc/api/v1/crops/'+id)
    return nil if response.status != 200

    JSON.parse(response.body)
  end

  def get_potential_open_farm_matches(name)
    response = Excon.get('https://openfarm.cc/api/v1/crops/?filter='+name)
    puts "THIS NAME WAS USED" + name
    return nil if response.status != 200

    JSON.parse(response.body)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant
      @plant = Plant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plant_params
      params.require(:plant).permit(:kingdom_id, :division_id, :plant_class_id, :order_id, :family_id, :genus_id, :species_id, :variety_id, :cultivator_id, :image_url, :OpenFarmID)
    end
end
