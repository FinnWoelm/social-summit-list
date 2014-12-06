class AddEditCode < ActiveRecord::Migration
  def change
    add_column :summits, :edit_code, :string, {:null => true, :default => nil}
  end
end
