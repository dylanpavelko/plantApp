class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin

  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = Wishlist.all
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new(:user_id => params[:user_id], :plant_id => params[:plant_id])
  end

  # GET /wishlists/1/edit
  def edit
  end

  def add_to_wishlist
    @wishlist = Wishlist.new(:user_id => params[:user], :plant_id => params[:plant])
    @wishlist.save
    redirect_to my_plants_path
  end

  # POST /wishlists
  # POST /wishlists.json
  def create
    @wishlist = Wishlist.new(wishlist_params)

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render :show, status: :created, location: @wishlist }
      else
        format.html { render :new }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Wishlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:user_id, :plant_id)
    end
end
