class AddUserIdAndIsActiveOptionToDataContent < ActiveRecord::Migration
  def change
    add_column :mobi_cms_data_contents, :is_active, :boolean, :default => false
    add_column :mobi_cms_data_contents, :user_id, :integer
  end
end
