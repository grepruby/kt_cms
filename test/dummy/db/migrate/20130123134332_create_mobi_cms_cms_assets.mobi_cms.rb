# This migration comes from mobi_cms (originally 20130109082755)
class CreateMobiCmsCmsAssets < ActiveRecord::Migration
  def change
    create_table :mobi_cms_cms_assets do |t|
      t.string :file

      t.timestamps
    end
  end
end
