
 # * @class Generic event queue: stores events and retrieves them based on their time
 
class RotRails::EventQueue 

	def initialize()
		@time = 0
		@events = []
		@eventTimes = []
	end


	# * @returns {number} Elapsed time
	 
	def getTime
		return @time
	end


	 # * Clear all scheduled events
	 
	def clear
		@events = []
		@eventTimes = []
		return self
	end


	 # * @param {?} event
	 # * @param {number} time
	 
	def add(event, time)
		index = @events.length
		for i in 0..@eventTimes.length-1
			if (@eventTimes[i] > time)
				index = i
				break
			end
		end

	 	@events.insert(index, event)
 		@eventTimes.insert(index, time)
	end


	 # * Locates the nearest event, advances time if necessary. Returns that event and removes it from the queue.
	 # * @returns {? || null} The event previously added by addEvent, null if no event available
 
	def get
		if (@events.empty?)
			return nil
		end

		time = @eventTimes.delete_at(0)
		if (time > 0)  # * advance 
			@time += time
			for i in 0..@eventTimes.length - 1
				@eventTimes[i] -= time 
			end
		end

		return @events.delete_at(0)
	end


	 # * Remove an event from the queue
	 # * @param {?} event
	 # * @returns {bool} success?
	 
	def remove(event)
		index = @events.index(event)
		if (index == nil) 
			return false
		end
		_remove(index)
		return true
	end

	private

		 # * Remove an event from the queue
		 # * @param {int} index
		 
		def _remove(index)
			@events.delete_at(index)
			@eventTimes.delete_at(index)
		end

end