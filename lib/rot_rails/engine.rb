# * @class Asynchronous main loop
# * @param {ROT.Scheduler} scheduler
class RotRails::Engine

	def initialize(scheduler)
		@scheduler = scheduler
		@lock = 1
	end

	# * Start the main loop. When this call returns, the loop is locked.
	def start
		return self.unlock()
	end

	# * Interrupt the engine by an asynchronous action
	def lock
		@lock += 1
		return self
	end

	# * Resume execution (paused by a previous lock)
	def unlock
		if (@lock == 0) 
			raise "Cannot unlock unlocked engine"
		end
		@lock -= 1

		while (@lock == 0) 
			actor = @scheduler.next()
			if (actor == nil) 
				return self.lock() # /* no actors */
			end
			result = actor[:act].call
			# if (result != nil && result[:then] != nil) #/* actor returned a "thenable", looks like a Promise */
			# 	self.lock()
			# 	result.then(self.unlock.bind(self))
			# end
		end

		return self
	end
end