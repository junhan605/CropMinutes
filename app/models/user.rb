class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable,
  #        :omniauthable, :omniauth_providers => [:facebook]
  devise :omniauthable, :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable

  has_and_belongs_to_many :companies
	accepts_nested_attributes_for :companies

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def has_companies?
	  errors.add(:companies, "must be specified.") if self.companies.blank?
	end

  def full_name
    ([first_name, last_name] - ['']).compact.join(' ')
  end
end
