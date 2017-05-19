class Product < ApplicationRecord
  class << self
    def export_file filetype, options = {}
      col_sep = options[:col_sep] || (filetype == "csv" ? "," : "\t")
      row_sep = options[:row_sep] || "\n"
      encoding = options[:encoding] || "utf-8"
      options = {col_sep: col_sep, row_sep: row_sep, encoding: encoding}
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |product|
          csv << product.attributes.values_at(*column_names)
        end
      end
    end
  end
end
