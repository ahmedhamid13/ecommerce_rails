class Store < ApplicationRecord
    belongs_to :user
    has_many :products

    validate :check_remaining
    validates :name, presence: true

    after_create do
        self.user.seller_role = true  #after creating store go and make this assign user seller4
        self.user.save
      end

    def check_remaining #handle that only one user owns one store
      errors.add(:base, "Sorry, this user owns a store")  if self.user.seller_role?
    end

end