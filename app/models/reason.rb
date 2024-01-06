class Reason < ApplicationRecord
  belongs_to :storefront

  validates :code, presence: true, uniqueness: { scope: :storefront_id }
  validates :label, presence: true

  scope :ordered, -> { order(ordering: :asc) }

  after_create :set_ordering

  private

  def set_ordering
    max_ordering = self.storefront.reasons.maximum(:ordering) || 0
    update_column(:ordering, max_ordering + 1)
  end
end
