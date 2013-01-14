class AddMobiCmsAdmin < ActiveRecord::Migration
  def change
    unless column_exists?(user_class, :cms_admin)
      add_column user_class, :cms_admin, :boolean, :default => false
    end
  end

  def user_class
    MobiCms.user_class.table_name.downcase.to_sym
  end
end
