class Company < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :minutes
  accepts_nested_attributes_for :minutes
end
