class PlantInstancesController < ApplicationController
  before_action :authenticate_user_admin, except: [:my_plants_api, :add_plant_instance]
  skip_before_action :verify_authenticity_token, only: [:add_plant_instance]
  before_action :authenticate_user

  before_action :set_plant_instance, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_request!, only: [:my_plants_api]

  # GET /plant_instances
  # GET /plant_instances.json
  def index
    @plant_instances = PlantInstance.all
  end
  
  def my_plants
    @hlf = HighLevelLocation.where(:user_id => @current_user.id)
    @local_moment = DateTime.now.in_time_zone('Pacific Time (US & Canada)')
    @wishlist_plants = Wishlist.where(:user_id => @current_user.id)
  end

  def my_plants_api
  puts "request my plants api"
  authorization_object = Authorization.new(request)
  puts "current user " + authorization_object.current_user.to_s + " id"
  if authorization_object.current_user == nil
    render json: {
        message: "Incorrect username/password combination"}, status: :unauthorized
  else 
  @current_user = authorization_object.current_user
  @hlf = HighLevelLocation.where(:user_id => @current_user)
  @locations = Array.new()
  @plants = []
  @hlf.each do |hlf|
    @ls = Location.where(:high_level_location_id => hlf.id)
    @ls.each do |l|
      @locations << l
      @ps = PlantInstance.where(:location_id => l.id)
      @ps.each do |p|
        @plants << p
      end
    end
  end

  @myplants = @plants.map do |p|
    { :id => p.id, :plant_id => p.plant.id, :location => p.location.name, :plant_name => p.plant.scientific_name_with_common_names}
  end
  puts @myplants.to_json
  puts 'return plants'
  respond_to do |format|
    msg = { :status => "ok", :message => "Success!", :html => "<b>...</b>" }
    format.json  { render :json => @myplants.to_json } # don't do msg.to_json
  end
  end
end

  # GET /plant_instances/1
  # GET /plant_instances/1.json
  def show
    @water_records = WaterRecord.where(:plant_instance_id => @plant_instance.id)
    @growth_observations = GrowthObservation.where(:plant_instance_id => @plant_instance)

    @photos = @plant_instance.get_photos

    @image_urls = Array.new
    @photos.each do |p|
      @image_urls << [p.id, url_for(p.picture)]
    end 
    
    if @plant_instance.start_date != nil
      days = Date.today - (@plant_instance.start_date + 1.days)
      @weather_records = WeatherRecord.where(:high_level_location_id => @plant_instance.location.high_level_location.id, :date => @plant_instance.start_date + 1..Date.today)
    else 
      days = 0
    end



    @growth_chart_data = Array.new()
    @dates = Array.new
    @germaination_data = Array.new()
    @early_data = Array.new()
    @main_data = Array.new()
    @flower_data = Array.new()
    @fdev_data = Array.new()
    @fmat_data = Array.new()
    @senes_data = Array.new()
    @min_temp_data = Array.new()
    @max_temp_data = Array.new()
    days.to_i.times do |i| 
      date = @plant_instance.start_date + i
      @dates << date.strftime('%m/%d/%Y')

      @weather = @weather_records.select { |wr| wr.date == date}
      if @weather.size > 0
        @min_temp_data << @weather.first.min_temp_f.to_f
        @max_temp_data << @weather.first.max_temp_f.to_f
      else
        @min_temp_data << nil
        @max_temp_data << nil
      end

      @observations = @growth_observations.select { |go| go.observation_date == date}
      if @observations.size > 0
        germo = false
        earlo = false
        maino = false
        flowo = false
        frdeo = false
        frmao = false
        seneo = false
        @observations.each do |observation|
          if observation.bbch_stage.code < 10
            @germaination_data << 100
            germo = true
          elsif observation.bbch_stage.code < 20
            if @early_data.last == nil
              @early_data.pop()
              @early_data << 0
            end
            if observation.percent_at_stage != nil
              @early_data << observation.percent_at_stage
            else
              @early_data << 100
            end
            earlo = true  
          elsif observation.bbch_stage.code < 50
            if @main_data.last == nil
              @main_data.pop()
              @main_data << 0
            end
            if observation.percent_at_stage != nil
              @main_data << observation.percent_at_stage
            else
              @main_data << 100
            end
            maino = true  
          elsif observation.bbch_stage.code < 70
            if @flower_data.last == nil
              @flower_data.pop()
              @flower_data << 0
            end  
            flowo = true
            @flower_data << 100 
          elsif observation.bbch_stage.code < 80  
            if @fdev_data.last == nil
              @fdev_data.pop()
              @fdev_data << 0
            end
            frdeo = true
            @fdev_data << 100
          elsif observation.bbch_stage.code < 90  
            if @fmat_data.last == nil
              @fmat_data.pop()
              @fmat_data << 0
            end
            frmao = true
            @fmat_data << 100  
          elsif observation.bbch_stage.code < 100  
            if @senes_data.last == nil
              @senes_data.pop()
              @senes_data << 0
            end
            seneo = true
            @senes_data << 100    
          end
        end
        if germo == false
            if @germaination_data.last != nil && @germaination_data.last != 0 && @early_data.last != nil
              @germaination_data << 100 - @early_data.last
            else
              @germaination_data << nil
            end
        end
        if earlo == false
          if @early_data.last != nil && @early_data.last != 0 && @main_data.last != nil
            @early_data << 100 - @main_data.last
          else
            @early_data << nil
          end
        end
        if maino == false
          if @main_data.last != nil && @main_data.last != 0
            @main_data << 100 - @flower_data.last
          else
            @main_data << nil
          end
        end
        if flowo == false
          if @flower_data.last != nil && @flower_data.last != 0
            @flower_data << 100 - @flower_data.last
          else
            @flower_data << nil
          end
        end
        if frdeo == false
          if @fdev_data.last != nil && @fdev_data.last != 0
            @fdev_data << 100 - @fdev_data.last
          else
            @fdev_data << nil
          end
        end
        if frmao == false
          if @fmat_data.last != nil && @fmat_data.last != 0 && @senes_data.last != nil
            @fmat_data << 100 - @senes_data.last
          else
            @fmat_data << nil
          end
        end
        if seneo == false
          if @senes_data.last != nil && @senes_data.last != 0
            @senes_data << 100
          else
            @senes_data << nil
          end
        end
      else
        @germaination_data << @germaination_data.last
        @early_data << @early_data.last
        @main_data << @main_data.last
        @flower_data << @flower_data.last
        @fdev_data << @fdev_data.last
        @fmat_data << @fmat_data.last
        @senes_data << @senes_data.last
      end
    end
    @growth_chart_data = @dates


    @growth_stages = BbchStage.where(:bbch_profile_id => @plant_instance.plant.get_bbch_profile_id).sort_by{|e| e[:code]}


    respond_to do |format|
      format.html  {render :show}
      format.json  { render :json => {:plant_instance => @plant_instance,
                                      :location => @plant_instance.location,
                                      :high_level_location => @plant_instance.location.high_level_location,
                                      :observations => @growth_observations,
                                      :pictures => @image_urls.reverse[0..15],
                                      :stages => @growth_stages }}
    end
  end

  # GET /plant_instances/new
  def new
    @plant_instance = PlantInstance.new(:plant_id => params[:plant_id])
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


  def add_plant_instance
    if params[:location_id] == "new"
      @new_location = Location.new(:name => params[:new_location_name], 
        :indoors => params[:new_location_indoors], 
        :high_level_location_id => params[:new_location_high_level_location])
      @new_location.save
      @location = @new_location
    else 
      @location = Location.find(params[:location_id])
    end

    if params[:propagation_type] == 1 #seed
      @plant_instance = PlantInstance.new(:plant_id => params[:plant_id], 
        :location_id => @location.id, 
        :planted_date => params[:planted_date], 
        :propagation_type => params[:propagation_type])
    elsif params[:propagation_type] == 2 #cutting
      @plant_instance = PlantInstance.new(:plant_id => params[:plant_id], 
        :location_id => @location.id, 
        :planted_date => params[:planted_date], 
        :propagation_type => params[:propagation_type])
    else
      @plant_instance = PlantInstance.new(:plant_id => params[:plant_id], 
        :location_id => @location.id, 
        :acquired_date => params[:planted_date])
    end
    
    respond_to do |format|
      if @plant_instance.save
        
        format.html { redirect_to @plant_instance, notice: 'Plant Instance was successfully created.' }
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
      params.require(:plant_instance).permit(:plant_id, :location_id, :planted_date, :acquired_date, :propagation_type, :sprout_date, :reference_name, :quantity)
    end
end
