class CreateMobiCmsDataContents < ActiveRecord::Migration
  def change
    create_table :mobi_cms_data_contents do |t|
      t.integer :content_type_id
      t.text :values

      t.timestamps
    end
  end
end
