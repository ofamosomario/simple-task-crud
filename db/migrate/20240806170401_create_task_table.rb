# frozen_string_literal: true

# Migrate
class CreateTaskTable < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :brand
      t.string :car_model
      t.string :price, :decimal, precision: 10, scale: 2
      t.string :url
      t.string :status

      t.timestamps
    end
  end
end
