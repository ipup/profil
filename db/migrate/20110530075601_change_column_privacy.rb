class ChangeColumnPrivacy < ActiveRecord::Migration
  # See http://webdevotion.be/blog/2010/06/16/change-a-column-type-when-using-postgresql-in-rails-migrations/
  def self.up
    # What we're trying to do is:
    # change_column :user_contents, :picture_confidential, :boolean
    # change_column :user_contents, :address_confidential, :boolean
    # change_column :user_contents, :description_confidential, :boolean
    # change_column :user_contents, :phone_confidential, :boolean
    # change_column :user_contents, :file_cv_confidential, :boolean
    
    # change_column :online_cv_fields, :confidential, :boolean
    
    # change_column :external_links, :confidential, :boolean
    
    # change_column :users, :email_confidential, :boolean
    # ---------------------------------------------------------------------------------- #
    # change_column :user_contents, :picture_confidential, :boolean    
    add_column :user_contents, :convert_picture_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    UserContent.reset_column_information

    # loop over the collection
    UserContent.all.each do |p|
        p.convert_picture_confidential = p.picture_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :user_contents, :picture_confidential
    # rename the convert_status to status column
    rename_column :user_contents,:convert_picture_confidential,:picture_confidential
    # ---------------------------------------------------------------------------------- #
        
    # change_column :user_contents, :address_confidential, :boolean    
    add_column :user_contents, :convert_address_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    UserContent.reset_column_information

    # loop over the collection
    UserContent.all.each do |p|
        p.convert_address_confidential = p.address_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :user_contents, :address_confidential
    # rename the convert_status to status column
    rename_column :user_contents,:convert_address_confidential,:address_confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :user_contents, :description_confidential, :boolean    
    add_column :user_contents, :convert_description_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    UserContent.reset_column_information

    # loop over the collection
    UserContent.all.each do |p|
        p.convert_description_confidential = p.description_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :user_contents, :description_confidential
    # rename the convert_status to status column
    rename_column :user_contents,:convert_description_confidential,:description_confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :user_contents, :phone_confidential, :boolean    
    add_column :user_contents, :convert_phone_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    UserContent.reset_column_information

    # loop over the collection
    UserContent.all.each do |p|
        p.convert_phone_confidential = p.phone_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :user_contents, :phone_confidential
    # rename the convert_status to status column
    rename_column :user_contents,:convert_phone_confidential,:phone_confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :user_contents, :file_cv_confidential, :boolean
    add_column :user_contents, :convert_file_cv_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    UserContent.reset_column_information

    # loop over the collection
    UserContent.all.each do |p|
        p.convert_file_cv_confidential = p.file_cv_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :user_contents, :file_cv_confidential
    # rename the convert_status to status column
    rename_column :user_contents,:convert_file_cv_confidential,:file_cv_confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :online_cv_fields, :confidential, :boolean    
    add_column :online_cv_fields, :convert_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    OnlineCvField.reset_column_information

    # loop over the collection
    OnlineCvField.all.each do |p|
        p.convert_confidential = p.confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :online_cv_fields, :confidential
    # rename the convert_status to status column
    rename_column :online_cv_fields,:convert_confidential,:confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :external_links, :confidential, :boolean  
    add_column :external_links, :convert_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    ExternalLink.reset_column_information

    # loop over the collection
    ExternalLink.all.each do |p|
        p.convert_confidential = p.confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :external_links, :confidential
    # rename the convert_status to status column
    rename_column :external_links,:convert_confidential,:confidential
    # ---------------------------------------------------------------------------------- #
    
    # change_column :users, :email_confidential, :boolean
    add_column :users, :convert_email_confidential, :boolean, :default => true
    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    User.reset_column_information

    # loop over the collection
    User.all.each do |p|
        p.convert_email_confidential = p.email_confidential == '1'
        p.save
    end
    # remove the older status column
    remove_column :users, :email_confidential
    # rename the convert_status to status column
    rename_column :users,:convert_email_confidential,:email_confidential
    # ---------------------------------------------------------------------------------- #
  end

  def self.down
    change_column :user_contents, :picture_confidential, :integer
    change_column :user_contents, :address_confidential, :integer
    change_column :user_contents, :description_confidential, :integer
    change_column :user_contents, :phone_confidential, :integer
    change_column :user_contents, :file_cv_confidential, :integer
    
    change_column :online_cv_fields, :confidential, :integer
    
    change_column :external_links, :confidential, :integer
    
    change_column :users, :email_confidential, :integer
  end
end
