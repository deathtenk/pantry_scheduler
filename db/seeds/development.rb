require 'faker'
Faker::Config.locale = 'en-US'

require 'discrete_distribution'

# Login user
User.create!(
  email: 'admin@example.com',
  password: 'abc123',
  password_confirmation: 'abc123',
)

possible_num_children = DiscreteDistribution.new(
  0 => 3,
  1 => 6,
  2 => 6,
  3 => 5,
  4 => 4,
  5 => 3,
  6 => 2,
  20 => 1,
)

possible_num_adults = DiscreteDistribution.new(
  1 => 9,
  2 => 9,
  3 => 6,
  4 => 3,
  5 => 1,
)

possible_counties = DiscreteDistribution.new(
  'PG' => 20,
  'AA' => 5,
  'Howard' => 3,
)

# TODO Randomize whether optional fields are present
100.times do
  county = possible_counties.sample

  Client.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: "#{Faker::Address.street_address}#{', ' + Faker::Address.secondary_address if rand < 0.2}",
    phone_number: Faker::PhoneNumber.phone_number,
    cell_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    county: county,
    zip: Faker::Address.zip,
    num_adults: possible_num_adults.sample,
    num_children: possible_num_children.sample,
    usda_cert_date: (Faker::Date.between(11.months.ago, Date.today + 1.month) if county == 'PG'),
    usda_qualifier: county == 'PG',
  )
end
