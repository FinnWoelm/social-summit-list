class Summit < ActiveRecord::Base
  # Required dependency for ActiveModel::Errors
  extend ActiveModel::Naming
  
#  def validation_check
#    errors.add(:name, "cannot be nil") if name.blank?
#    errors.add(:date_start, "cannot be nil") if date_start.blank?
#    errors.add(:date_end, "cannot be nil") if date_end.blank?
#    errors.add(:name, "roflmao")
##    summit.errors.add(:location_city, "cannot be nil") if summit.location_city.blank?
##    summit.errors.add(:location_state, "cannot be nil") if summit.location_state.blank?
##    summit.errors.add(:currency, "cannot be nil") if summit.currency.blank?
##    summit.errors.add(:cost, "cannot be nil") if summit.cost.blank?
##    summit.errors.add(:deadline, "cannot be nil") if summit.deadline.blank?
##    summit.errors.add(:fields, "cannot be nil") if summit.fields.blank?
##    summit.errors.add(:cost, "cannot be nil") if summit.language.blank?
##    summit.errors.add(:description, "cannot be nil") if summit.description.blank?
#    if errors.count == 0
#      return true
#    else
#      return false
#    end
#  end
  
#  
#  def self.validate_summit summit
#    summit.errors.add(:name, "cannot be nil") if summit.name.blank?
#    summit.errors.add(:date_start, "cannot be nil") if summit.date_start.blank?
#    summit.errors.add(:date_end, "cannot be nil") if summit.date_end.blank?
#    summit.errors.add(:location_city, "cannot be nil") if summit.location_city.blank?
#    summit.errors.add(:location_state, "cannot be nil") if summit.location_state.blank?
#    summit.errors.add(:currency, "cannot be nil") if summit.currency.blank?
#    summit.errors.add(:cost, "cannot be nil") if summit.cost.blank?
#    summit.errors.add(:deadline, "cannot be nil") if summit.deadline.blank?
#    summit.errors.add(:fields, "cannot be nil") if summit.fields.blank?
#    summit.errors.add(:cost, "cannot be nil") if summit.language.blank?
#    summit.errors.add(:description, "cannot be nil") if summit.description.blank?
#    if summit.errors.count == 0
#      return true
#    else
#      return false
#    end
#  end
  
  validates_presence_of :name, :date_start, :date_end, :location_city, :location_state, :currency, :cost, :deadline, :fields, :language, :description
  
  validates :name, length: { minimum: 2 }
  
  validates :cost, numericality: { :only_integer => true, :greater_than_or_equal_to => 0}
  
  validates :deadline, format: { with: /[0-9]{4}\/[01][0-9]\/[0-3][0-9]/, message: "must be in format YYYY/MM/DD" }
end
