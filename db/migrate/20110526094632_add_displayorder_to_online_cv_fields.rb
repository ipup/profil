class AddDisplayorderToOnlineCvFields < ActiveRecord::Migration
  def self.up
    add_column :online_cv_fields, :displayorder, :integer
  end

  def self.down
    remove_column :online_cv_fields, :displayorder
  end
end
