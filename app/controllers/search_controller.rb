class SearchController < ApplicationController

  def index
    @common_names = CommonName.where("name LIKE ?", "%#{params[:query]}%")
  end

end
