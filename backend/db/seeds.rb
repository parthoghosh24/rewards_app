# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

reward_list = [
  {title: "Playstation 5",
  points: 2000},
  {title: "Xbox One",
  points: 1800},
  {title: "Nintendo Switch",
  points: 1000},
  {title: "Meta Oculus Quest 3",
  points: 1500},
  {title: "Book",
  points: 1000},
  {title: "Shoes",
  points: 500},
  {title: "Gift card",
  points: 100},
  {title: "Poster",
  points: 80},
  {title: "Toaster",
  points: 50},
  {title: "Socks",
  points: 20}
]

puts "Seeding rewards"
reward_list.each do |reward|
    Reward.find_or_create_by!(reward)
end
puts "Rewards seeded #{Reward.count}"