class Calendar < ApplicationRecord
  has_many :events, dependent: :destroy
  has_one :user
end
