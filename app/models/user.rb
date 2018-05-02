class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable
  belongs_to :organization, inverse_of: :users, optional: true

  ROLES = %w(admin super member doctor patient).freeze

  scope :with_role, -> (role) { where('users.roles @> ?', "{#{role}}") }

  def roles_list
    (roles || []).join(',')
  end

  def roles=(roles)
    roles = Array(roles)
    roles << 'admin' if roles.include?('super') && !roles.include?('admin')
    roles.reject! { |role| !ROLES.include?(role.to_s) }
    super(roles)
  end

  def add_role(role)
    return if has_role?(role)
    self.roles = (roles || []) + [role.to_s]
  end

  def add_role!(role)
    add_role(role)
    save!
  end

  def remove_role(role)
    self.roles = (roles || []).map(&:to_s) - [role.to_s]
  end

  def remove_role!(role)
    remove_role(role)
    save!
  end

  def has_role?(role)
    (roles || []).map(&:to_s).include?(role.to_s)
  end

  def with_best_role
    if is_admin?
      is_a?(Admin) ? self : becomes(Admin)
    elsif is_technician?
      is_a?(Member) ? self : becomes(Member)
    elsif is_doctor?
      is_a?(Doctor) ? self : becomes(Doctor)
    elsif is_patient?
      is_a?(Patient) ? self : becomes(Patient)
    else
      self
    end
  end
end
