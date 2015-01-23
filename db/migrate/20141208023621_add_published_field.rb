class AddPublishedField < ActiveRecord::Migration
  def change
    add_column :summits, :published, :boolean, :null => false, :default => false
  end
end
