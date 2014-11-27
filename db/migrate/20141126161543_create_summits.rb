class CreateSummits < ActiveRecord::Migration
  def change
    create_table :summits do |t|
      t.string :name, :null => false
      t.text :deadline, :null => false
      t.string :location_city, :null => false
      t.string :location_state, :null => true, :default => nil
      t.string :location_country, :null => false
      t.string :language, :null => false
      t.date :date_start, :null => false
      t.date :date_end, :null => false
      t.integer :cost, :null => false
      t.string :currency, :null => false
      t.text :fields, :null => false
      t.boolean :idea_stage, :null => false, :default => false
      t.boolean :planning_stage, :null => false, :default => false
      t.boolean :implementation_stage, :null => false, :default => false
      t.boolean :operating_stage, :null => false, :default => false
      t.string :contact_website, :null => true, :default => nil
      t.string :contact_email, :null => true, :default => nil
      t.string :admin_email, :null => false
      t.string :admin_url, :null => false
      
      t.text :description, :null => false
      t.text :requirements, :null => true, :default => nil

      t.timestamps
    end
  end
end
