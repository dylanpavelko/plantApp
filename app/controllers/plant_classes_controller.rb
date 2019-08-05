class PlantClassesController < ApplicationController
  before_action :set_plant_class, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin, only: [:new, :create, :edit, :update, :destroy]
  
  # GET /plant_classes
  # GET /plant_classes.json
  def index
    @plant_classes = PlantClass.all
  end

  # GET /plant_classes/1
  # GET /plant_classes/1.json
  def show
    @orders = Order.where(:plant_class_id => @plant_class.id)
  end

  # GET /plant_classes/new
  def new
    @plant_class = PlantClass.new
  end

  # GET /plant_classes/1/edit
  def edit
  end

  # POST /plant_classes
  # POST /plant_classes.json
  def create
    @plant_class = PlantClass.new(plant_class_params)

    respond_to do |format|
      if @plant_class.save
        format.html { redirect_to @plant_class, notice: 'Plant class was successfully created.' }
        format.json { render :show, status: :created, location: @plant_class }
      else
        format.html { render :new }
        format.json { render json: @plant_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plant_classes/1
  # PATCH/PUT /plant_classes/1.json
  def update
    respond_to do |format|
      if @plant_class.update(plant_class_params)
        format.html { redirect_to @plant_class, notice: 'Plant class was successfully updated.' }
        format.json { render :show, status: :ok, location: @plant_class }
      else
        format.html { render :edit }
        format.json { render json: @plant_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plant_classes/1
  # DELETE /plant_classes/1.json
  def destroy
    @plant_class.destroy
    respond_to do |format|
      format.html { redirect_to plant_classes_url, notice: 'Plant class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant_class
      @plant_class = PlantClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plant_class_params
      params.require(:plant_class).permit(:name, :description, :division_id)
    end
end
