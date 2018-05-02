class Organization < ApplicationRecord
  validates :subdomain, uniqueness: { case_sensitive: false }
  validates_presence_of :name

  has_many :users, inverse_of: :organization

  after_create :create_tenant

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
