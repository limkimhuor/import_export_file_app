class Product < ApplicationRecord
  class << self
    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |product|
          csv << product.attributes.values_at(*column_names)
        end
      end
    end

    def import file
      #import spreadsheet
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        product.attributes = row.to_hash
        product.save!
      end

      # CSV.foreach(file.path, headers: true) do |row|
      #   # Product.create! row.to_hash # import new
      #   product = find_by_id(row["id"]) || new
      #   product.attributes = row.to_hash
      #   product.save!
      # end
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
      else raise "Unknow file type: #{file.original_filename}"
      end
    end
  end
end
