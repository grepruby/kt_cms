# This migration comes from mobi_cms (originally 20130114091104)
class AddUserIdAndIsActiveOptionToDataContent < ActiveRecord::Migration
  def change
    add_column :mobi_cms_data_contents, :is_active, :boolean, :default => false
    add_column :mobi_cms_data_contents, :user_id, :integer
  end
end
