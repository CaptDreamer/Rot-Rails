String.class_eval do 

	# * Left pad
	# * @param {string} [character="0"]
	# * @param {int} [count=2]
	def lpad(character, count)
		ch = character || "0"
		cnt = count || 2

		s = ""
		while (s.length < (cnt - self.length))
			s += ch
		end
		s = s[0, cnt-self.length]
		return s+self
	end

	# * Right pad
	# * @param {string} [character="0"]
	# * @param {int} [count=2]
	def rpad(character, count)
		ch = character || "0"
		cnt = count || 2

		s = ""
		while (s.length < (cnt - self.length))
			s += ch
		end
		s = s[0, cnt-self.length]
		return self+s
	end

	# * @returns {string} First letter capitalized
	def capitalize()
		return self[0].upcase + self[1, self.length]
	end

end


Array.class_eval do

	# @returns {any} Randomly picked item, nil when length=0
	def random()
		if (self.length == 0)
			return nil
		end
		return self[(RotRails::RNG.getUniform() * self.length).floor]
	end

	# * @returns {array} New array with randomized items
	def randomize()
		oldArray = self.dup
		result = []
		while (oldArray.length > 0)
			index = oldArray.index(oldArray.random())
			result.push(oldArray[index])
			oldArray.delete_at(index)
		end
		return result
	end
end