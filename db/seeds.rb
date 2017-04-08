user = User.create(
  first_name: 'Tyler',
  last_name: 'Brewer',
  email: 'tylerbrewer02@gmail.com'
)

puts 'Created New User'

group = Group.create(
  name: 'Cool Group'
)

puts 'Created New Group'

list = List.create(
  group_id: group.id,
  user_id: user.id
)

puts 'Created New List'

5.times do |index|
  list.items << Item.create(
    name: "Item ##{index}",
    url: 'tylerbrewerdesign.com',
    price: 100.00,
    list_id: list.id
  )

  puts 'Created New Item'
end
