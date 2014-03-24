class CountriesController < ApplicationController

  def welcome
  end

  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def show
    @country = Country.find(params[:id])
  end

  def create
    name = country_params["name"].titleize
    @country = Country.find_or_create_by(:name => name)
    if @country.find_all_values
      @country.hdi = Hdi.new(@country.find_all_values)
      if @country.save
        redirect_to countries_show_path(@country)
      else
        flash.now[:error] = "Spelling error"
        render :new
      end
    else
      flash.now[:error] = "Spelling error"
      render :new
    end
  end

  def update
    @country = Country.find(params[:id])
    if @country.find_all_values
      @country.hdi = Hdi.new(@country.find_all_values)
      if @country.save
        redirect_to countries_show_path(@country)
      else
        flash.now[:error] = "Spelling error"
        render :new
      end
    else
      flash.now[:error] = "Spelling error"
      render :new
    end
  end

  private
  def country_params
    params.require(:country).permit(:name)
  end

end
