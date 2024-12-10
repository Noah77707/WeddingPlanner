class User < ApplicationRecord
  has_one :calendar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for Google OmniAuth
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      user.google_access_token = auth.credentials.token
      user.google_refresh_token = auth.credentials.token
      user.google_token_expires_at = Time.at(auth.credentials.expires_at)
    end
  end
end
