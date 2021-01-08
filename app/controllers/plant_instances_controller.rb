class PlantInstancesController < ApplicationController
  before_action :authenticate_user_admin  #make this not be admin only
  before_action :set_plant_instance, only: [:show, :edit, :update, :destroy]

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

  # GET /plant_instances/1
  # GET /plant_instances/1.json
  def show
    @water_records = WaterRecord.where(:plant_instance_id => @plant_instance.id)
    @growth_observations = GrowthObservation.where(:plant_instance_id => @plant_instance)


    days = Date.today.mjd - @plant_instance.acquired_date.mjd + 1

    @growth_chart_data = Array.new()
    @dates = Array.new
    @germaination_data = Array.new()
    @early_data = Array.new()
    @main_data = Array.new()
    @flower_data = Array.new()
    @fdev_data = Array.new()
    @fmat_data = Array.new()
    @senes_data = Array.new()
    days.times do |i| 
      date = @plant_instance.acquired_date + i
      @dates << date.strftime('%m/%d/%Y')
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
            @early_data << 100
            earlo = true  
          elsif observation.bbch_stage.code < 50
            maino = true 
            @main_data << 100  
          elsif observation.bbch_stage.code < 70  
            flowo = true
            @flower_data << 100 
          elsif observation.bbch_stage.code < 80  
            frdeo = true
            @fdev_data << 100
          elsif observation.bbch_stage.code < 90  
            frmao = true
            @fmat_data << 100  
          elsif observation.bbch_stage.code < 100  
            seneo = true
            @senes_data << 100    
          end
        end
        if germo == false
            if @germaination_data.last != nil && @germaination_data.last != 0
              @germaination_data << 100 - @early_data.last
            else
              @germaination_data << nil
            end
        end
        if earlo == false
            @early_data << nil
        end
        if maino == false
          @main_data << nil
        end
        if flowo == false
          @flower_data << nil
        end
        if frdeo == false
          @fdev_data << nil
        end
        if frmao == false
          @fmat_data << nil
        end
        if seneo == false
          @senes_data << nil
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
      params.require(:plant_instance).permit(:plant_id, :location_id, :planted_date, :acquired_date, :propagation_type, :sprout_date)
    end
end
