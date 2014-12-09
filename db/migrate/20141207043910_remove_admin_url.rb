class RemoveAdminUrl < ActiveRecord::Migration
  def change
    remove_column :summits, :admin_url
  end
end
