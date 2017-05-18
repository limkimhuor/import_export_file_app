require "factory_girl_rails"

namespace :db do
  desc "Recreate product"
  task remake_data: :environment do

    %w[db:drop db:create db:migrate db:seed db:test:prepare].each do |task|
      Rake::Task[task].invoke
    end

    puts "Create new product"
    ActiveRecord::Base.transaction do
      50.times do
        Product.create name: Faker::Commerce.product_name, price: Faker::Commerce.price,
          released_on: Faker::Date.between(6.months.ago, 6.months.from_now)
      end
    end

    puts "Product created"
  end
end
