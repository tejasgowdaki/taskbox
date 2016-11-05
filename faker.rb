10.times do 
	client = Client.new
	client.name = Faker::Name.name
	client.email = Faker::Internet.email
	client.mobile = Faker::Number.number(10)
	client.company = Faker::Company.name
	client.website = "www.#{Faker::Internet.domain_name}"
	client.user_id = User.all.sample.id
	client.save
end

20.times do
	project = Project.new
	project.name = Faker::App.name
	project.description = Faker::Lorem.paragraph
	project.start_date = Faker::Date.between(Date.today.beginning_of_year,Date.today)
	project.client_id = Client.all.sample.id 
	project.status = ["new","on-going","completed"].sample
	project.user_id = User.all.sample.id
	project.save
end

1000.times do 
	product = Product.new
	product.name = Faker::Commerce.product_name
	product.price = Faker::Commerce.price(100..1000)
	product.category = Faker::Commerce.department(1)
	product.brand = ["Peter England", "People", "Wrangler", "United Colors of Benetton", "Jack & Jones", "Adidas", "Arrow", "Calvin Klein", "GAS", "John Players"].sample
	product.size = ["S", "M", "L", "XL", "XXL"].sample
	product.discount = ["10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%"].sample
	product.color = Faker::Commerce.color
	product.availability = Faker::Boolean.boolean
	product.save
end

30.times do
	task = Task.new
	task.title = Faker::Book.title
	task.project_id = Project.all.ids.sample
	task.due_date = Faker::Date.forward(30)
	task.is_completed = Faker::Boolean.boolean
	task.save
end