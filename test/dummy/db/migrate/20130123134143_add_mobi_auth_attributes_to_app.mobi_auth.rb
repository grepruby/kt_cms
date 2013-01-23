# This migration comes from mobi_auth (originally 20130123100640)
class AddMobiAuthAttributesToApp < ActiveRecord::Migration
  def change

    unless column_exists?(user_class, :email)
      add_column user_class, :email, :string, null: false
    end

    unless column_exists?(user_class, :name)
      add_column user_class, :name, :string, null: false
    end

    unless column_exists?(user_class, :handle)
      add_column user_class, :handle, :string, null: false
    end

  end

  def user_class
    MobiAuth.user_class.table_name.downcase.to_sym
  end
end
