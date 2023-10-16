class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_one_attached :avatar
  after_create_commit :register_stripe_customer
  has_many :ai_components
  has_many :user_roles
  has_one :subscription
  has_secure_token :email_token

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token.first(6)
      user.email = auth.info.email
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  def self.free_users
    includes(:subscription).where.not(subscription: { status: :active }).or(
      includes(:subscription).where(subscription: { id: nil }))
  end

  def self.paid_users
    includes(:subscription).where(subscription: { status: :active })
  end

  def avatar_display
    if avatar.attached?
      avatar
    elsif avatar_url.present?
      avatar_url
    else
      "https://gravatar.com/avatar/c553f5893997262b965cb8fa9e34df6a?s=200&d=mp&r=g"
    end
  end

  def register_stripe_customer
    RegisterStripeCustomerJob.perform_later(id)
  end

  def active_subscription
    Subscription.where(user: self, status: :active).first
  end

  def google_authed?
    uid.present? && provider == "google_oauth2"
  end
  # User roles

  def admin?
    user_roles.find_by(role: Role.admin_role).present?
  end
end
