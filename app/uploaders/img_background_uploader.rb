class ImgBackgroundUploader < CarrierWave::Uploader::Base
  # We include RMagick for image processing
  include CarrierWave::RMagick
  # Amazon Storage
  storage :s3

  # Repertory where the file is going to be saved
  def store_dir
    "uploads/#{model.id}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Accepted extensions.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Each time a file is uploaded, we create its thumb
  # See carrierwave and RMagick doc for more options
  # Thumb is being used in the 'BackEnd Themes' part
  version :thumb do
    process :resize_to_limit => [200, 200]
  end
end
