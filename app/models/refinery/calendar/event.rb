module Refinery
  module Calendar
    class Event < Refinery::Core::BaseModel
      extend FriendlyId

      friendly_id :title, :use => :slugged

      belongs_to :venue

      belongs_to :image

      validates :title, :presence => true, :uniqueness => true
      validates :seats, :numericality => true
      validates :seat_cost, :numericality => true

      attr_accessible :title, :from, :to, :registration_link,
                      :venue_id, :excerpt, :description,
                      :featured, :position, :seats, :seat_cost, :image_id

      delegate :name, :address,
                :to => :venue,
                :prefix => true,
                :allow_nil => true

      class << self
        def upcoming
          where('"refinery_calendar_events.from" >= ?', Time.now)
        end

        def featured
          where(:featured => true)
        end

        def archive
          where('"refinery_calendar_events.from" < ?', Time.now)
        end
      end
    end
  end
end
