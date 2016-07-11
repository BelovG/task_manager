class User < ActiveRecord::Base
  has_secure_password

  before_save { email.downcase! }
  before_create :create_remember_token

  validates_presence_of :email, :password_digest, :role
  validates :email, uniqueness: { case_sensitive: false }

  enum role: [:user, :admin]

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
