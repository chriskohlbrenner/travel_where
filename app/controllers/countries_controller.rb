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
    @country = Country.new(country_params)
    if @country.find_hdi_value_2012
      @hdi_value = @country.find_hdi_value_2012
      @country.hdi = Hdi.new(:hdi_value_2012 => @hdi_value)
      if @country.save
        redirect_to countries_show_path(@country)
      else
        render :new
      end
    else
      render :new
    end
  end

  def update
    @country = Country.find(params[:id])
    if @country.find_hdi_value_2012
      @hdi_value = @country.find_hdi_value_2012
      @country.hdi = Hdi.new(:hdi_value_2012 => @hdi_value)
      if @country.save
        redirect_to countries_show_path(@country)
      else
        render :new
      end
    else
      render :new
    end
  end

  private
  def country_params
    params.require(:country).permit(:name)
  end

end
