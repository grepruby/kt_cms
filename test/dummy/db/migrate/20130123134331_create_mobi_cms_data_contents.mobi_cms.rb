# This migration comes from mobi_cms (originally 20121228064028)
class CreateMobiCmsDataContents < ActiveRecord::Migration
  def change
    create_table :mobi_cms_data_contents do |t|
      t.integer :content_type_id
      t.text :values

      t.timestamps
    end
  end
end
