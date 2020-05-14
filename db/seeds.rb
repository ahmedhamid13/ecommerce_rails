require 'faker'

# 10.times do
#     User.create(
#         name: Faker::Name.name , 
#         email: Faker::Internet.email, 
#         password: "123456", 
#         password_confirmation: "123456"
#     )
# end

8.times do
    Category.create(name: Faker::Device.platform)
    Brand.create(name: Faker::Device.manufacturer)
end
        Store.create(
            name: Faker::Device.manufacturer,
            summary: Faker::Hacker.say_something_smart,
            user_id: (User.all.sample).id
        )

25.times do |t|
    Product.create(
        title: Faker::Device.platform,
        price: Faker::Number.decimal(l_digits: 4, r_digits: 2),
        quantity: Faker::Number.between(from: 10, to: 50),
        description: Faker::Hacker.say_something_smart,
        category_id: (Category.all.sample).id,
        brand_id: (Brand.all.sample).id,
        store_id: (Store.all.sample).id,
    )

    4.times do
        Rate.create(
            rate: Faker::Number.between(from: 1, to:5),
            user_id: (User.all.sample).id,
            product_id: (Product.all.sample).id
        )
        Review.create(
            comment: Faker::Hacker.say_something_smart,
            user_id: (User.all.sample).id,
            product_id: (Product.all.sample).id
        )
    end

    # Image.create(
    #     source: Faker::Avatar.image,
    #     product_id: t
    # )
end
