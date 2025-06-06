# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }
  after_update_commit { broadcast_update }
  has_many :messages
  has_one_attached :avatar

  has_many :joinables, dependent: :destroy
  has_many :joined_rooms, through: :joinables, source: :room
  validates_uniqueness_of :username, required: true, case_sensitive: false

  has_many :notifications, dependent: :destroy, as: :recipient

  enum role: %i[user admin moderator owner]
  enum status: %i[offline away online dnd]

  after_commit :add_default_avatar, on: %i[create update]

  after_initialize :set_default_role, if: :new_record?

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  def chat_avatar
    avatar.variant(resize_to_limit: [50, 50]).processed
  end

  def navbar_avatar
    avatar.variant(resize_to_limit: [25, 25]).processed
  end

  def broadcast_update
    broadcast_replace_to 'user_status', partial: 'users/status', user: self
  end

  def has_joined_room(room)
    joined_rooms.include?(room)
  end

  def status_to_css
    status_css_map = {
      'online' => 'bg-success',
      'away' => 'bg-warning',
      'offline' => 'bg-dark',
      'dnd' => 'bg-danger'
    }
    status_css_map[status] || 'bg-dark'
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'galaxy.jpg')),
      filename: 'galaxy.jpg',
      content_type: 'image/jpg'
    )
  end

  def set_default_role
    self.role ||= :user
  end
end
