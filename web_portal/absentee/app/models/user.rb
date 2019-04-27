class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def get_auth_token
    self.update(auth_token: User.generate_auth_token)
    return self.auth_token
  end

  def self.generate_auth_token
    loop do
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless User.where(auth_token: random_token).exists?
    end
  end

  def delete_auth_token
    self.auth_token = nil
    self.save
  end


end
