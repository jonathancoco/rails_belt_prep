class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, :location, :state, :event_date, presence: true
  validate :event_date_cannot_be_in_the_past

  has_many :comments, :dependent => :delete_all
  has_many :attendings, :dependent => :delete_all
  has_many :users, through: :attendings
  #has_many :attendees, through: :attendings, :foreign_key => 'user_id', :source =>'user'
  def event_date_cannot_be_in_the_past
    if event_date.present? && event_date < Date.today
      errors.add(:event_date, "can't be in the past")
    end
  end
end
