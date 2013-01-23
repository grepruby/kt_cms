# This migration comes from mobi_cms (originally 20121226070331)
class CreateMobiCmsContentTypes < ActiveRecord::Migration
  def change
    create_table :mobi_cms_content_types do |t|
      t.string :name
      t.text :content_type_attributes
      t.text :template

      t.timestamps
    end
  end
end
