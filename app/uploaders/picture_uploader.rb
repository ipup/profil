class PictureUploader < CarrierWave::Uploader::Base
  # We include RMagick for image processing
  include CarrierWave::RMagick
  # Amazon Storage
  storage :s3

  # Pictures will be cropped in order to be exactly 200x200
  # See RMagick documentation for other processing such as
  # process :resize_to_fit => [200,200]
  # process :resize_to_fill => [200,200]
  process :resize_to_limit => [200, 200]
  
  # Repertory where the file is going to be saved
  def store_dir
    "uploads/#{model.id}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Accepted extensions.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
