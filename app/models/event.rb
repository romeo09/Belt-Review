class Event < ActiveRecord::Base
   belongs_to :user
   belongs_to :join
   has_many :joins, dependent: :destroy
   has_many :guests, through: :joins, source: :user

   validates :name, :presence => true
   validates :date, :presence => true
   validates :city, :presence => true
   validates :state, :presence => true
   validate :past_event
   def past_event
      errors.add(:date, "Event cannot be made before today's date, #{Date.today.strptime('%m / %d / %Y')}") if !date.blank? && date < Date.today
   end
end
