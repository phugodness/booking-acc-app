class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }

  has_one :phone_number, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id', dependent: :destroy
  has_many :personal_messages, dependent: :destroy
  belongs_to :role
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  do_not_validate_attachment_file_type :image
  has_attached_file :image, default_url: '/img/:style/missing.png'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image_file_name = auth.info.image
    end
  end

  def admin?
    self.role.name == 'Admin'
  end

  def host?
    self.role.name == 'Host'
  end

  def regular?
    self.role.name == 'Regular'
  end

end
