# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def admin_seed
  if Rails.env.development?
    AdminUser.create!(email: "admin@example.com", password: "password",
                      password_confirmation: "password")
  end
end

require "uri"
require "net/http"
require "openssl"
require "json"
require "date"

TOKEN_API = "api-ce.kroger.com/v1/connect/oauth2/token".freeze
CLIENT_ID = "grampsmarket-b1b6dd2ff88a5c7a0b5b88ee2d40ac9a6171680135351100340".freeze
CLIENT_SECRET = "x0wOaFLyzCxA0bDt9gyoxunjhKKqhTZ6msEUDmN1".freeze
PRODUCT_API = "api-ce.kroger.com/v1/products".freeze

def find_token
  token_url = URI.parse("https://#{TOKEN_API}")
  http = Net::HTTP.new(token_url.host, token_url.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(token_url)
  request["Content_Type"] = "application/x-www-form-urlencoded"
  request["Authorization"] =
    "Basic Z3JhbXBzbWFya2V0LWIxYjZkZDJmZjg4YTVjN2EwYjViODhlZTJkNDBhYzlhNjE3MTY4MDEzNTM1MTEwMDM0MDp4MHdPYUZMeXpDeEEwYkR0OWd5b3h1bmpoS0txaFRaNm1zRVVEbU4x"
  request.body = "grant_type=client_credentials&scope=product.compact"
  response = http.request(request)
  JSON.parse(response.read_body)
end

# Random Date Generator
def random_date_between(first, second)
  number_of_days = (first - second).abs
  [first, second].min + rand(number_of_days)
end

# Categories
def category_seed
  product_categories = %w[soup fruit cereal snack vegetable beverage dairy]
  product_categories.each do |category|
    Category.create(name: category)
  end
end

# Products
def product_seed(auth)
  location_filter = "filter.location=0160050" # Kroger store in Findlay, OH
  limit = "filter.limit=18"

  Category.all.each do |category|
    category_filter = "filter.term=#{category['name']}"
    url = URI("https://#{PRODUCT_API}?#{location_filter}&#{category_filter}&#{limit}&price")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Accept"] = "application/json"
    request["Authorization"] = "Bearer #{auth['access_token']}"

    response = http.request(request)
    # json_response = response.read_body
    json_response = JSON.parse(response.read_body)

    next if json_response.blank?

    json_response["data"].each do |record|
      image_records = record["images"]
      image_records = image_records.find { |images| images["perspective"] == "front" }
      image_records = image_records["sizes"]
      image_records = image_records.find { |images| images["size"] == "medium" }
      image_records = image_records["url"]

      Product.create(
        category:,
        name:        record["description"],
        brand:       record["brand"],
        inventory:   rand(51),
        floor_date:  random_date_between(Time.zone.today, Date.civil(2022, 6, 10)),
        SKU:         record["upc"],
        price:       format("%.2f", rand(0.1) * 10),
        taxable_GST: (category["name"] != "dairy"),
        taxable_PST: (category["name"] != "dairy"),
        taxable_HST: (category["name"] != "dairy"),
        details:     record["itemInformation"],
        image_url:   image_records
      )
    end
  end
end

# Provinces
def province_seed
  provinces = [
    { name: "BC", PST: 7.0, GST: 5.0, HST: nil },
    { name: "AB", PST: nil, GST: 5.0, HST: nil },
    { name: "SK", PST: 6.0, GST: 5.0, HST: nil },
    { name: "MB", PST: 7.0, GST: 5.0, HST: nil },
    { name: "ON", PST: nil, GST: nil, HST: 13.0 },
    { name: "QB", PST: 9.975, GST: 5.0, HST: nil },
    { name: "PEI", PST: nil, GST: nil, HST: 15.0 },
    { name: "NS", PST: nil, GST: nil, HST: 15.0 },
    { name: "NL", PST: nil, GST: nil, HST: 15.0 },
    { name: "NB", PST: nil, GST: nil, HST: 15.0 },
    { name: "YT", PST: nil, GST: 5.0, HST: nil },
    { name: "NWT", PST: nil, GST: 5.0, HST: nil },
    { name: "NV", PST: nil, GST: 5.0, HST: nil }
  ]
  provinces.each do |prov|
    Province.create(
      name: prov[:name],
      PST:  prov[:PST],
      GST:  prov[:GST],
      HST:  prov[:HST]
    )
  end
end

# admin_seed
auth = find_token
# category_seed
product_seed(auth)
# province_seed
