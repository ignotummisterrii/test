class Vehicle < ApplicationRecord
	has_many :way_points
	validates_presence_of :identifier
	
	def last_way_point
		self.way_points.order(:sent_at).last
	end

	

end
