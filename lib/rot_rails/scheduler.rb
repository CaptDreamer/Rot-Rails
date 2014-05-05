# * @class Abstract scheduler
class RotRails::Scheduler

	def initialize()
		@queue = RotRails::EventQueue.new
		@repeat = []
		@current = nil
	end

	# * @see RotRails::EventQueue#getTime
	def getTime
		return @queue.getTime()
	end

	# * @param {?} item
	# * @param {bool} repeat
	def add(item, repeat)
		if (repeat)
			@repeat.push(item) 
		end
		return self
	end

	# * Clear all items
	def clear
		@queue.clear()
		@repeat = []
		@current = nil
		return self
	end

	# * Remove a previously added item
	# * @param {?} item
	# * @returns {bool} successful?
	def remove(item)
		result = @queue.remove(item)

		index = @repeat.index(item)
		if (index != nil) 
			@repeat.delete_at(index)
		end

		if (@current == item)
			@current = nil 
		end

		return result
	end

	# * Schedule next item
	# * @returns {?}
	def next
		@current = @queue.get()
		return @current
	end

		# * @class Simple fair scheduler (round-robin style)
		# * @augments RotRails::Scheduler
		class RotRails::Scheduler::Simple < RotRails::Scheduler

			def initialize()
				super
			end

			#* @see RotRails::Scheduler#add
			def add(item, repeat)
				@queue.add(item, 0)
				return super(item, repeat)
			end

			# * @see RotRails::Scheduler#next
			def next
				if (@current != nil && @repeat.index(@current) != nil)
					@queue.add(@current, 0)
				end
				return super
			end
		end

		#  * @class Speed-based scheduler
		#  * @augments RotRails::Scheduler
		class RotRails::Scheduler::Speed < RotRails::Scheduler

			def initialize()
				super
			end

			# * @param {objectend item anything with "getSpeed" method
			# * @param {boolend repeat
			# * @see RotRails::Scheduler#add
			def add(item, repeat)
				@queue.add(item, 1/item[:getSpeed].call.to_f)
				return super(item, repeat)
			end

			# * @see RotRails::Scheduler#next
			def next
				if (@current != nil && @repeat.index(@current) != nil) 
					@queue.add(@current, 1/@current[:getSpeed].call.to_f)
				end
				return super
			end
		end

		#  * @class Action-based scheduler
		#  * @augments RotRails::Scheduler
		class RotRails::Scheduler::Action < RotRails::Scheduler
			def initialize()
				super
				@defaultDuration = 1 #/* for newly added */
				@duration = @defaultDuration #/* for @current */
			end

			# * @param {objectend item
			# * @param {boolend repeat
			# * @param {numberend [time=1]
			# * @see RotRails::Scheduler#add
			def add(item, repeat, time = 1)
				@queue.add(item, time || @defaultDuration)
				return super(item, repeat)
			end

			def clear
				@duration = @defaultDuration
				return super
			end

			def remove(item)
				if (item == @current) 
					@duration = @defaultDuration 
				end
				return super(item)
			end

			# * @see RotRails::Scheduler#next
			def next
				if (@current != nil && @repeat.index(@current) != nil)
					@queue.add(@current, @duration || @defaultDuration)
					@duration = @defaultDuration
				end
				return super
			end

			# * Set duration for the active item
			def setDuration(time)
				if (@current) 
					@duration = time 
				end
				return self
			end
		end
end
