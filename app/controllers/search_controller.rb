class SearchController < ApplicationController

  def index
    @common_names = CommonName.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    @genus = Genu.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    @species = Species.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    
    @plants = Array.new
    
    #get plants by common name
    @common_names.each do |cn|
        @plants.push(cn.plant)
    end
    
    #get plants by genus
    @genus.each do |g|
        @g_species = Species.where(:genus_id => g.id)
        @g_species.each do |gs|
            @gsp = Plant.where(:species_id => gs.id)
            @gsp.each do |p|
                @plants.push(p)
            end
        end
    end
    
    @species.each do |s|
        @sp = Plant.where(:species_id => s.id)
        @sp.each do |plant_species|
            @plants.push(plant_species)
        end
    end
    
    @plants = @plants.uniq
    
    puts "number of plants:" 
    puts @plants.size
    
    #@plants = Plant.where('id IN (?)', @plants.uniq!)
    
    puts @plants.inspect
    #@first_plant = Plant.find(@plants.first.id)
    
    respond_to do |format|
        #format.html { render plant_url @first_plant }
        format.json { @plants }
    end
    
  end

end
