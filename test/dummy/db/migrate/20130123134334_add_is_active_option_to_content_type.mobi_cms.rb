# This migration comes from mobi_cms (originally 20130114091245)
class AddIsActiveOptionToContentType < ActiveRecord::Migration
  def change
    add_column :mobi_cms_content_types, :is_active, :boolean, :default => false
  end
end
