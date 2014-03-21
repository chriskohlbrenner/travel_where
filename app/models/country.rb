# Need to mess with this or the controller:
#   If statements or rescue based on bad searches
#   Suggest correct term if misspelled
#   How to search for countries with multiple names (united states)

class Country < ActiveRecord::Base
  before_save :capitalize_name!
  has_one :hdi, dependent: :destroy

  def self.find_hdi_value_2012(country_name)
    uri = URI.parse("http://data.undp.org/resource/wxub-qc5k.json?name=#{country_name}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri) 
    response = http.request(request)
    hash_data = JSON.parse(response.body)
    hash_data.first["_2012_hdi_value"] if hash_data != []
  end

  def great_to_visit?
    self.hdi.hdi_value_2012 >= 0.7
  end

  def ok_to_visit?
    0.7 > self.hdi.hdi_value_2012 && self.hdi.hdi_value_2012 >= 0.5
  end

  def bad_to_visit?
    0.5 > self.hdi.hdi_value_2012
  end


  def capitalize_name!
    self.name.capitalize!
  end
end