# Need to mess with this or the controller:
#   If statements or rescue based on bad searches
#   Suggest correct term if misspelled
#   How to search for countries with multiple names (united states) - check

class Country < ActiveRecord::Base
  # before_create :check_spelling
  before_create :titleize_name!
  has_one :hdi, dependent: :destroy
  validates_presence_of :hdi

  def fix_name_for_search
    search = self.name.clone
    search.gsub!(/(laos)/i,"Lao People's Democratic Republic")
    search.gsub!(/(bolivia)/i,"Bolivia (Plurinational State of)")
    search.gsub!(/(south korea)/i,"Korea (Republic of)")
    search.gsub!(/(north korea)/i,"Korea (Democratic People's Rep. of)") # still screwy - N. Korea has no hdi value
    search.gsub!(/(hong kong)/i,"Hong Kong, China (SAR)")
    search.gsub!(/(venezuela)/i,"Venezuela (Bolivarian Republic of)")
    search.gsub!(/(iran)/i,"Iran (Islamic Republic of)")
    search.gsub!(/(micronesia)/i,"Micronesia (Federated States of)")
    search.gsub!(/(moldova)/i,"Moldova (Republic of)")
    search.gsub!(/(tanzania)/i,"Tanzania (United Republic of)")
    search.gsub!(/(congo)/i,"Congo (Democratic Republic of the)")
    search.gsub!(/(russia)/i,"Russian Federation")
    search.gsub!(/(yugoslavia)/i,"The former Yugoslav Republic of Macedonia")
    search.gsub(" ", "%20").gsub("'", "%27").gsub("(", "%28").gsub(")", "%29")

  end

  def find_values
    search = fix_name_for_search
    uri = URI.parse("http://data.undp.org/resource/wxub-qc5k.json?name=#{search}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri) 
    response = http.request(request)
    hash_data = JSON.parse(response.body)
    if hash_data.first
      hash_data.first
    else
      false
    end
  end

  def find_all_values
    if find_values
      {
        :hdi_value => find_values["_2012_hdi_value"],
        :expected_years_of_schooling => find_values["_2011_expected_years_of_schooling"],
        :mean_years_of_schooling => find_values["_2010_mean_years_of_schooling"],
        :hdi_rank => find_values["_2012_hdi_rank"],
        :life_expectancy_at_birth => find_values["_2012_life_expectancy_at_birth"],
        :gross_national_income_gni_per_capita => find_values["_2012_gross_national_income_gni_per_capita"]
      }
    else
      false
    end
  end

  def great_to_visit?
    self.hdi.hdi_value.to_f >= 0.700
  end

  def ok_to_visit?
    0.700 > self.hdi.hdi_value.to_f && self.hdi.hdi_value.to_f >= 0.500
  end

  def bad_to_visit?
    0.500 > self.hdi.hdi_value.to_f
  end

  private
  def titleize_name!
    self.name = self.name.titleize
  end

  def check_spelling
    # if self.name = 
  end
end