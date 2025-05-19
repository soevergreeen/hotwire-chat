class Room < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true,
            length: { in: 4..15 },
            format: { without: /\A\d+\z/, message: 'must contain non-digit characters' }
  has_many :messages
  broadcasts
end
