# frozen_string_literal: true

# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    brand { 'Toyota' }
    car_model { 'Corolla' }
    price { 200 }
    url { 'https://example.com/car' }
    status { 'available' }
  end
end
