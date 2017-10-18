class Task < ApplicationRecord
  validates :status, presence: true, length: { maximum: 10 }
  validates :contet, presence: true, length: { maximum: 255 }
end