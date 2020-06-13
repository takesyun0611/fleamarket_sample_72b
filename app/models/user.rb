class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  has_many :shipments

  validates :nickname, presence: true
  [family_name, given_name, family_name_kana, given_name_kana].each do |v|
    validates v,
      format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  end
  validates :birthday, presence: true
end
