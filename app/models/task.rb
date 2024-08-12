# frozen_string_literal: true

# Task
class Task < ApplicationRecord
  validates :price, presence: false, numericality: { greater_than_or_equal_to: 0 }
end
