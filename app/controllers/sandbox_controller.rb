class SandboxController < ApplicationController
  def clients
  	@clients = Client.all
  end

  def projects
  	@projects = Project.where('start_date > ? AND start_date < ?', Date.today.beginning_of_month-3.months,Date.today.beginning_of_month).order('start_date')
  end

  def products
=begin

    1. List all products based on a given category
    2. List products based on price range
    3. List products based on brand
    4. List products based on size of a certain brand falling within a given price range
    5. List products that are available
    6. List products following under price 499
    7. List products upto price 1200
    8. List all products based on the categories
    9. List only products which are available
    10. List products price descending and name ascending
    11. List products whose prices are the same as a group
    12. Display the total worth of the products
    13. Display total worth of products in each category
    14. List all products based on the categories


=end
	# 1
	@category = "Toys"
	@products_category = Product.where('category = ?', @category).limit(20)

	#2
	@price_range_min = 300
	@price_range_max = 500
	@products_price_range = Product.where('price >= ? AND price <= ?', @price_range_min, @price_range_max).limit(20)

	#3
	@brand = "Peter England"
	@products_brand = Product.where('brand = ?', @brand).limit(20)

	#4
	@size = "XL"
	@products_size = Product.where('size = ? AND brand = ? AND price >= ? AND price <= ?', @size, @brand, @price_range_min, @price_range_max).limit(20)

	#5
	@products_available = Product.where('availability = ? ', "t").limit(20)

	#6
	@price = 499
	@products_price = Product.where('price <= ?', @price).limit(20)

	#7
	@price = 999 
	@products_price_upto = Product.where('price <= ?', @price).limit(20)

	#8
	@category_product_hash = {}
	@products = Product.all.limit(20)
	@products.each do |product|
		if @category_product_hash.has_key? product.category 
			@category_product_hash[product.category].push(product.name)
		else
			#@category_product_hash[product.category] = []
			@category_product_hash[product.category] = [product.name]
		end
	end

	#9
	#same as 5th query

	#10
	@products 
	@price_name_order = @products.order('price DESC', 'name')


	#11
	@products = Product.all
	@price_group_hash = {}
	@products.each do |product|
		if @price_group_hash.has_key? product.price
			@price_group_hash[product.price].push(product.name)
		else
			@price_group_hash[product.price] = [product.name]
		end
	end
=begin
	@price_group_hash["0 - 25"] = @products.where('price >= ? AND price <= ?', 0, 25).limit(10)
	@price_group_hash["26 - 50"] = @products.where('price >= ? AND price <= ?', 26, 50).limit(10)
	@price_group_hash["51 - 75"] = @products.where('price >= ? AND price <= ?', 51, 75).limit(10)
	@price_group_hash["76 - 99"] = @products.where('price >= ? AND price <= ?', 76, 99).limit(10)
=end


	#12
	@total_worth = Product.sum(:price)
=begin
	@total_worth = 0
	@products = Product.all
	@products.each do |product|
		@total_worth += product.price
	end
=end
	#13
	@category_price_hash = {}
	@products = Product.all.limit(20)
	@products.each do |product|
		if @category_price_hash.has_key? product.category 
			@category_price_hash[product.category] += product.price
		else
			#@category_product_hash[product.category] = 0
			@category_price_hash[product.category] = product.price
		end
	end

	#14
	#same as query 8

	#15
	@category_hash = {}
	@products = Product.all
	@products.each do |product|
		if @category_hash.has_key? product.category 
			@category_hash[product.category]["names"].push(product.name)
			@category_hash[product.category]["total_worth"] += product.price
		else
			@category_hash[product.category] = {}
			@category_hash[product.category]["names"] = [product.name]
			@category_hash[product.category]["total_worth"] = product.price
		end
	end
end
end

