module RotRails::RNG

	@s0 = 0
	@s1 = 0
	@s2 = 0
	@c = 0
	@frac = 2.3283064365386963e-10 #/* 2^-32 */
	@seed = nil
	@initialized = false

	# * @returns {number} 
	def self.getSeed()
		return @seed
	end

	# * @param {int} lowerBound The lower end of the range to return a value from, inclusive
	# * @param {int} upperBound The upper end of the range to return a value from, inclusive
	# * @returns {int} Pseudorandom value [lowerBound, upperBound], using ROT.RNG.getUniform() to distribute the value
	def self.getUniformInt(lowerBound, upperBound)
		max = [lowerBound, upperBound].max
		min = [lowerBound, upperBound].min
		return (self.getUniform() * (max - min + 1)).floor + min
	end

	# * @returns {int} Pseudorandom value [1,100] inclusive, uniformly distributed
	def self.getPercentage()
		return 1 + (this.getUniform()*100).floor
	end
	
	# * @param {object} data key=whatever, value=weight (relative probability)
	# * @returns {string} whatever
	def self.getWeightedValue(data)
		avail = []
		total = 0
		
		for id in data
			total += data[id]
		end
		random = (self.getUniform()*total).floor
		
		part = 0
		for id in data
			part += data[id]
			if (random < part)
				return id
			end
		end
		
		return nil
	end

	# * Get RNG state. Useful for storing the state and re-setting it via setState.
	# * @returns {?} Internal state
	def self.getState()
		return [@s0, @s1, @s2, @c]
	end

	# * Set a previously retrieved state.
	# * @param {?} state
	def self.setState(state)
		@s0 = state[0]
		@s1 = state[1]
		@s2 = state[2]
		@c  = state[3]
		@initialized = true
	end


	# * @param {number} seed Seed the number generator
	def self.setSeed(seed)
		seed = (seed < 1 ? 1/seed : seed)

		@seed = seed
		@s0 = (seed >> 0) * @frac

		seed = (seed*69069 + 1) >> 0
		@s1 = seed * @frac

		seed = (seed*69069 + 1) >> 0
		@s2 = seed * @frac

		@c = 1
		@initialized = true
	end


	def self.getNormal(mean, stddev)
		begin
			u = 2*self.getUniform()-1
			v = 2*self.getUniform()-1
			rInt = u*u + v*v
		end while (rInt > 1 || rInt == 0)

		gauss = u * Math.sqrt(-2*Math.log(rInt)/rInt)
		return (mean || 0) + gauss*(stddev || 1)
	end

	# * @returns {float} Pseudorandom value [0,1), uniformly distributed
	def self.getUniform()
		if (!@initialized)
			self.setSeed(DateTime.now.to_i)
		end
		t = 2091639 * @s0 + @c * @frac
		@s0 = @s1
		@s1 = @s2
		@c = t.to_i | 0.to_i
		@s2 = t - @c
		return @s2
	end

end