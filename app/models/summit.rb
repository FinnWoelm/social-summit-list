class Summit < ActiveRecord::Base
  
  validates_presence_of :name, :date_start, :date_end, :location_city, :location_state, :currency, :cost, :deadline, :fields, :language, :description
  
  validates :name, length: { minimum: 2 }
  
  validates :cost, numericality: { :only_integer => true, :greater_than_or_equal_to => 0}
  
  #validates :deadline, format: { with: /[0-9]{4}\/[01][0-9]\/[0-3][0-9]/, message: "must be in format YYYY/MM/DD" }
end
