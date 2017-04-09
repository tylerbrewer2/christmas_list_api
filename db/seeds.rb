user = User.find_or_create_by(
  first_name: 'Tyler',
  last_name: 'Brewer',
  email: 'tylerbrewer02@gmail.com'
)

puts 'Created New User'

user2 = User.find_or_create_by(
  first_name: 'Harry',
  last_name: 'Potter',
  email: 'firebolt9000@hogwarts.edu'
)

puts 'Created New User'

group = Group.find_or_create_by(
  name: 'Cool Group'
)

puts 'Created New Group'

group2 = Group.find_or_create_by(
  name: 'Awesome Group'
)

puts 'Created New Group'

list = List.find_or_create_by(
  group_id: group.id,
  user_id: user.id
)

puts 'Created New List'

List.find_or_create_by(
  group_id: group2.id,
  user_id: user2.id
)

puts 'Created New List'

List.find_or_create_by(
  group_id: group.id,
  user_id: user2.id
)

puts 'Created New List'

5.times do |index|
  list.items << Item.find_or_create_by(
    name: "Item ##{index}",
    url: 'https://tylerbrewerdesign.com',
    price: 100.00,
    list_id: list.id
  )

  puts 'Created New Item'
end
