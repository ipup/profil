# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
NameUp::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end

