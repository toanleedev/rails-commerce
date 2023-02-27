# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  birth                  :datetime
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  full_name              :string
#  gender                 :integer
#  locked_at              :datetime
#  password_digest        :string
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default(0)
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :full_name, presence: true
  before_create :generate_token
  before_save { self.email = email.downcase }

  protected

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.confirmation_sent_at = Time.current
    generate_token if User.exists?(confirmation_token: self.confirmation_token)
  end
end
