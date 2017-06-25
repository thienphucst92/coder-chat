class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_intensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  has_many :relationships
  has_many :request_friends, through: :relationships, class_name: 'Relationship'
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_relationships, source: :user

  has_many :friends, -> {where(relationships: {status: 'friend'})}, through: :relationships, source: :friend

  def unread_messages
    received_messages.where(read_at: nil)
  end

  def get_relationship(user)
    if relationship = Relationship.where(friend_id: user.id, user_id: id).take
			relationship.status
    end
  end

  def friend_request
    friend_request = []
    inverse_relationships.each do |relation|
      if relation.status == 'pending'
        friend_request << User.find_by(id: relation.user_id)
      end
    end

    friend_request
  end

end
