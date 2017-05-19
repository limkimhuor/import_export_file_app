class ProductsController < ApplicationController
  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.csv {send_data @products.export_file("csv") }
      format.xlsx {
        response.headers["Content-Disposition"] = 'attachment; filename="all_products.xlsx"'
      }
      format.xls { send_data @products.export_file("xls"), filename: "all_products.xls", disposition: "attachment" }
    end
  end
end
