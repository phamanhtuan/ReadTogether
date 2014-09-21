class Translation < ActiveRecord::Base
	belongs_to :vocabulary
	validates_presence_of :meaning
end
