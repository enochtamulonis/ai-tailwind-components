class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_one_attached :avatar
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token.first(6)
      user.email = auth.info.email
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end
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
end
