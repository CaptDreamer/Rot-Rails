String.class_eval do 
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
end