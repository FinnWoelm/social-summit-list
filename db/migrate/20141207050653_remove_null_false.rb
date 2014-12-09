class RemoveNullFalse < ActiveRecord::Migration
  def change
    change_column :summits, :name, :string, :null => true, :default => nil
    change_column :summits, :deadline, :text, :null => true, :default => nil
    change_column :summits, :application_link, :string, :null => true, :default => nil
    change_column :summits, :location_city, :string, :null => true, :default => nil
    change_column :summits, :location_state, :string, :null => true, :default => nil
    change_column :summits, :location_country, :string, :null => true, :default => nil
    change_column :summits, :language, :string, :null => true, :default => nil
    change_column :summits, :date_start, :date, :null => true, :default => nil
    change_column :summits, :date_end, :date, :null => true, :default => nil
    change_column :summits, :cost, :integer, :null => true, :default => nil
    change_column :summits, :currency, :string, :null => true, :default => nil
    change_column :summits, :fields, :text, :null => true, :default => nil
    change_column :summits, :idea_stage, :boolean, :null => false, :default => false
    change_column :summits, :planning_stage, :boolean, :null => false, :default => false
    change_column :summits, :implementation_stage, :boolean, :null => false, :default => false
    change_column :summits, :operating_stage, :boolean, :null => false, :default => false
    change_column :summits, :contact_website, :string, :null => true, :default => nil
    change_column :summits, :contact_email, :string, :null => true, :default => nil
    change_column :summits, :admin_email, :string, :null => true, :default => nil
    change_column :summits, :description, :text, :null => true, :default => nil
    change_column :summits, :requirements, :text, :null => true, :default => nil
  end
end
