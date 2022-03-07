class PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin, only: [:new, :create, :edit, :update, :destroy]
  #before_action :set_user, only: [:show]

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
    @resources = Resource.where(:plant_id => @plant)
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
    if @current_user != nil
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
    end
     
    #eventually make this all public plant photos not just all photos
    @photos = Array.new
    @all_plant_instances =  PlantInstance.where(:plant_id => @plant).order(created_at: :desc)
    @all_plant_instances.each do |instance|
      @photos += instance.get_photos
    end
    puts "PHOTOS"


    @bbch_profile = @plant.species.bbch_profile
    if @bbch_profile != nil
      @bbch_stages = BbchStage.where(:bbch_profile_id => @bbch_profile).sort_by &:code
      @growth_stages = GrowthStage.where(:species_id => @plant.species.id).sort_by &:bbch_code
    end
    

    @has_open_farm_data = false
    if @plant.OpenFarmID != nil and @plant.OpenFarmID != ""
      #@open_farm_data = get_open_farm_data(@plant.OpenFarmID)
      @has_open_farm_data = true
    end

    #@potential_matches = get_potential_open_farm_matches(@plant.scientific_name)


    if @current_user != nil
      @averages = WeatherAverage.where(:high_level_location => @current_user.high_level_location).sort_by &:day
    else
      @averages = nil
    end

    @max_temp_data = Array.new
    @min_temp_data = Array.new
    @min_deviation_data = Array.new
    @max_deviation_data = Array.new
    @date_labels = Array.new
    @start_planting_dates = Array.new
    @stop_planting_dates = Array.new
    # @precip_data = Array.new
    @gdd_data = Array.new
    @ytd_gdd_data = Array.new
    @days_to_harvest_data = Array.new
    @harvest_risk_colors = Array.new
    @temp_colors = ['#990000', '#9b0402', '#9d0704', '#9e0a05', '#a00e07', '#a11108', '#a3140a',
      '#a4180b', '#a61b0d', '#a81e0f', '#a92110', '#ab2512', '#ac2813', '#ae2b15', '#af2f16', '#b13218',
      '#b3351a', '#b4381b', '#b63c1d', '#b73f1e', '#b94220', '#ba4621', '#bc4923', '#be4c25', '#bf5026',
      '#c15328', '#c25629', '#c4592b', '#c55d2c', '#c7602e', '#c96330', '#ca6731', '#cc6a33', '#cd6d34',
      '#cf7036', '#d07437', '#d27739', '#d47a3b', '#d57e3c', '#d7813e', '#d8843f', '#da8741', '#db8b42',
      '#dd8e44', '#df9146', '#e09547', '#e29849', '#e39b4a', '#e59f4c', '#e6a24d', '#e8a54f', '#eaa851',
      '#ebac52', '#edaf54', '#eeb255', '#f0b657', '#f1b958', '#f3bc5a', '#f5bf5c', '#f6c35d', '#f8c65f',
      '#f9c960', '#fbcd62', '#fcd063', '#fed365', '#ffd666', '#fbd367', '#f7d168', '#f3cf69', '#efcd69',
      '#eccb6a', '#e8c96b', '#e4c76b', '#e0c56c', '#ddc36d', '#d9c16e', '#d5bf6e', '#d1bd6f', '#cebb70',
      '#cab970', '#c6b771', '#c2b572', '#bfb373', '#bbb173', '#b7af74', '#b3ad75', '#b0ab75', '#aca976',
      '#a8a777', '#a4a577', '#a1a378', '#9da179', '#999f7a', '#959d7a', '#929b7b', '#8e997c', '#8a977c',
      '#86957d', '#83937e', '#7f917f', '#7b8f7f', '#778d80', '#748b81', '#708981', '#6c8782', '#688583',
      '#658384', '#618184', '#5d7f85', '#597d86', '#567b86', '#527987', '#4e7788', '#4a7588', '#477389',
      '#43718a', '#3f6f8b', '#3b6d8b', '#386b8c', '#34698d', '#30678d', '#2c658e', '#29638f', '#256190',
      '#215f90', '#1d5d91', '#1a5b92', '#165992', '#125793', '#0e5594', '#0b5394']

    #get gdd data
    #v1 just get the first harvestable data and use that for the entire life cycle (go back and use each stage)
    @growth_stage_data = GrowthStage.where(:species => @plant.species, :harvestable => true).sort_by(&:bbch_code)
    if @growth_stage_data.count > 0
      @growing_conditions = @growth_stage_data.first
      puts "how many growth stages"
      puts @growth_stage_data.count
      puts " did we get here:"
      @growing_conditions = @growth_stage_data.first
      damage_min_temp_f = @growing_conditions.cold_damage_risk
      damage_max_temp_f = @growing_conditions.heat_damage_risk
      gdd_base = @growing_conditions.growth_base
      gdd_cutoff = @growing_conditions.growth_cutoff
      harvest_gdd = @growing_conditions.min_agdd
    
      running_gdd=0

      if @averages != nil
        @averages.each do |ad|
          @date_labels << ((Date.new(y=2020, m=12, d=31) + ad.day).strftime("%m/%d"))
          @max_temp_data << ad.max_temp_f
          @min_temp_data << ad.min_temp_f
          # @precip_data << ad.precip_in
          @max_deviation_data << ad.max_temp_f + ad.max_t_std_dev
          @min_deviation_data << ad.min_temp_f - ad.min_t_std_dev

          if ad.min_temp_f > gdd_base
            low = ad.min_temp_f
          else
            low = gdd_base
          end
          if gdd_cutoff != nil && ad.max_temp_f > gdd_cutoff
            high = gdd_cutoff
          else
            high = ad.max_temp_f
          end

          gdd = (high + low) / 2 - gdd_base

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
            if((i + days_to_harvest) >= 365)
              doy = i + days_to_harvest - 365
            else
              doy = i + days_to_harvest
            end
            agdd += @gdd_data[doy]
            days_to_harvest += 1
            if (damage_min_temp_f != nil && @min_temp_data[doy]  < damage_min_temp_f)
              frost_risk = true
            end
            if damage_max_temp_f != nil && @max_temp_data[doy] > damage_max_temp_f
              heat_risk = true
            end
          end
          @days_to_harvest_data << days_to_harvest
          if frost_risk && heat_risk
            if @harvest_risk_colors.last == "#129840"
              @stop_planting_dates << i
            end
            @harvest_risk_colors << "#FF00FF"
          elsif frost_risk
            if @harvest_risk_colors.last == "#129840"
              @stop_planting_dates << i
            end
            @harvest_risk_colors << "#0000FF"
          elsif heat_risk
            if @harvest_risk_colors.last == "#129840"
              @stop_planting_dates << i
            end
            @harvest_risk_colors << "#FF0000"
          else
            if @harvest_risk_colors.last != "#129840" && i != 0
              @start_planting_dates << i
            end
            @harvest_risk_colors << "#129840"
          end
        end
      end
    end
    if @harvest_risk_colors[0] == "#129840"
      @stop_planting_dates = @stop_planting_dates.rotate(1)
    end

    
    @image_url = url_for(@plant.image_url) 

    @growing_recommendations = Array.new()
    @start_planting_dates.each_with_index do |start, i|
      @plant_start_date = Date.ordinal(2021, start+1).strftime('%b-%d')
      @plant_end_date = Date.ordinal(2021, @stop_planting_dates[i]+1).strftime('%b-%d')

      if start+1 + @days_to_harvest_data[start] > 365
        harvest_start = start+1 + @days_to_harvest_data[start] - 365
      else
        harvest_start = start+1 + @days_to_harvest_data[start]
      end
      @harvest_start_date = Date.ordinal(2021, harvest_start).strftime('%b-%d')
      if @stop_planting_dates[i]+1 + @days_to_harvest_data[@stop_planting_dates[i]] > 365
        harvest_end = @stop_planting_dates[i]+1 + @days_to_harvest_data[@stop_planting_dates[i]] - 365
      else
        harvest_end = @stop_planting_dates[i]+1 + @days_to_harvest_data[@stop_planting_dates[i]]
      end
      @harvest_end_date = Date.ordinal(2021, harvest_end).strftime('%b-%d')
      @growing_recommendations << [@plant_start_date, @plant_end_date, @harvest_start_date, @harvest_end_date]
    end

    respond_to do |format|
      format.html  {render :show}
      format.json  { render :json => {:plant => @plant,
                                      :cultivator => @plant.cultivator,
                                      :variety => @plant.variety,
                                      :species => @plant.species,
                                      :genus => @plant.genus,
                                      :family => @plant.family,
                                      :order => @plant.order,
                                      :plant_class => @plant.plant_class,
                                      :division => @plant.division,
                                      :kingdom => @plant.kingdom,
                                      :image_url => @image_url,
                                      :common_names => @common_names, 
                                      :resources => @resources,
                                      :plant_instances => @plant_instances.to_json(:include => :location),
                                      :growing_recommendations => @growing_recommendations,
                                      :user_id => @current_user }}
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
