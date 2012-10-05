class FileCvUploader < CarrierWave::Uploader::Base
  # Amazon Storage
  storage :s3

  # Repertory where the file is going to be saved
  def store_dir
    "uploads/#{model.id}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Accepted extensions.
  def extension_white_list
    %w(pdf doc docx)
  end
end
