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

    @locations = Array.new
    @plant_instances = Array.new
    @user_high_level_locations = HighLevelLocation.where(:user_id => @current_user)
    @user_high_level_locations.each do |hlf|
      @user_locations = Location.where(:high_level_location_id => hlf.id)
      @user_locations.each do |l|
        @locations << l
      end
    end
    @locations.each do |l|
      @user_plants = PlantInstance.where(:plant_id => @plant, :location_id => l.id)
      @user_plants.each do |p|
        @plant_instances << p
      end
    end
    
    #eventually make this all public plant photos not just all photos
    @photos = Array.new
    @all_plant_instances =  PlantInstance.where(:plant_id => @plant)
    @all_plant_instances.each do |instance|
      @photos += instance.get_photos
    end
    

    @has_open_farm_data = false
    if @plant.OpenFarmID != nil and @plant.OpenFarmID != ""
      @open_farm_data = get_open_farm_data(@plant.OpenFarmID)
      @has_open_farm_data = true
    end

    @potential_matches = get_potential_open_farm_matches(@plant.scientific_name)



    @averages = WeatherAverage.where(:high_level_location => @current_user.high_level_location).sort_by &:day
    
    @max_temp_data = Array.new
    @min_temp_data = Array.new
    @min_deviation_data = Array.new
    @max_deviation_data = Array.new
    @date_labels = Array.new
    # @precip_data = Array.new
    @gdd_data = Array.new
    @ytd_gdd_data = Array.new
    @days_to_harvest_data = Array.new
    @harvest_risk_colors = Array.new

    #gdd data
    gdd_base = 50
    gdd_cutoff = nil
    harvest_gdd = 1300  #example of tomato
    running_gdd=0
    damage_min_temp_f=35
    damage_max_temp_f=97

    @averages.each do |ad|
      @date_labels << ((Date.new(y=2020, m=12, d=31) + ad.day).strftime("%m/%d"))
      @max_temp_data << ad.max_temp_f
      @min_temp_data << ad.min_temp_f
      # @precip_data << ad.precip_in
      @max_deviation_data << ad.max_temp_f + ad.max_t_std_dev
      @min_deviation_data << ad.min_temp_f - ad.min_t_std_dev

      if ad.min_temp_f > gdd_base
        gdd = (ad.max_temp_f + ad.min_temp_f)/2 - gdd_base
      else
        gdd = (ad.max_temp_f + gdd_base)/2 - gdd_base
      end
      @gdd_data << gdd
      running_gdd += gdd
      @ytd_gdd_data << running_gdd
    end

    #build number of gdd from this day and store in @days to harvest
    @date_labels.each_with_index do |dl, i|
      agdd = 0
      days_to_harvest = 0
      frost_risk = false
      heat_risk = false
      while(agdd < harvest_gdd)
        if((i + days_to_harvest) > 365)
          doy = i + days_to_harvest - 365
        else
          doy = i + days_to_harvest
        end
        agdd += @gdd_data[doy]
        days_to_harvest += 1
        if (@min_temp_data[doy] ) < damage_min_temp_f
          frost_risk = true
        end
        if @max_temp_data[doy] > damage_max_temp_f
          heat_risk = true
        end
      end
      @days_to_harvest_data << days_to_harvest
      if frost_risk && heat_risk
        @harvest_risk_colors << "#FF00FF"
      elsif frost_risk
        @harvest_risk_colors << "#0000FF"
      elsif heat_risk
        @harvest_risk_colors << "#FF0000"
      else
        @harvest_risk_colors << "#129840"
      end
        
      
    end

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
