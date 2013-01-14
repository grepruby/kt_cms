class AddIsActiveOptionToContentType < ActiveRecord::Migration
  def change
    add_column :mobi_cms_content_types, :is_active, :boolean, :default => false
  end
end
