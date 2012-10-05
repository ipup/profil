class IconUploader < CarrierWave::Uploader::Base
  # We include RMagick for image processing
  include CarrierWave::RMagick
  # Amazon Storage
  storage :s3

  # Icons will be cropped in order to be exactly 32x32
  # See RMagick documentation for other processing such as
  # process :resize_to_fit => [32,32]
  # process :resize_to_limit => [32,32]
  process :resize_to_fill => [32, 32]
  
  # Repertory where the file is going to be saved
  def store_dir
    "uploads/#{model.id}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Accepted extensions.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
