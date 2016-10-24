class User < ActiveRecord::Base
   belongs_to :join
   has_many :events, dependent: :destroy
   has_many :joins, dependent: :destroy
   has_many :events_attended, through: :joins, source: :event
   has_secure_password

   email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

   validates :first_name, :presence => true
   validates :last_name, :presence => true
   validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
   validates :city, :presence => true
   validates :state, :presence => true
   validates :password, :length => { minimum: 8 }, :presence => true
   validates_presence_of :password, on: :new
   validates_confirmation_of :password, :allow_blank => false

end
