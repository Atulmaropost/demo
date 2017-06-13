class Gallery < ApplicationRecord
	validates_uniqueness_of :name, :case_sensitive => false
	mount_uploader :gallery_image, GalleryUploader
	
	belongs_to :user
  attr_accessor :flash_notice

	require 'roo'

  
  def self.import(file,user)
    response_hash = {success: 0, failed: 0, failed_rows: []}
    spreadsheet = open_file(file)
    header = spreadsheet.row(1)
    if header.present?
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        gallery = Gallery.new(user_id: user.id, name: row["name"].downcase, remote_gallery_image_url: row["gallery_image"])
        if gallery.save
          response_hash[:success] += 1
        else
          response_hash[:failed] += 1
          response_hash[:failed_rows].push({"#{i.to_s}": gallery.errors.full_messages})
        end
      end
      response_hash  
    end  
  end

	def self.open_file(file)
    case File.extname(file.path)
      when ".csv" then
        Roo::CSV.new(file.path,csv_options: {encoding: Encoding::UTF_8}, header: true)
      when ".xls" then
        Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end



end
