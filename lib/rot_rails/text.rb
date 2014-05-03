module RotRails::Text
	
	RE_COLORS = /%([bc]){([^}]*)}/

	# token types */
	TYPE_TEXT =		0
	TYPE_NEWLINE =	1
	TYPE_FG =		2
	TYPE_BG =		3
	

	# Measure size of a resulting text block
	def self.measure(str, maxWidth)
		result = {width:0, height:1}
		tokens = self.tokenize(str, maxWidth)
		lineWidth = 0

		for i in 0..tokens.length-1
			token = tokens[i]
			case token[:type]
				when TYPE_TEXT
					lineWidth += token[:value].length

				when TYPE_NEWLINE
					result[:height] += 1
					result[:width] = [result[:width], lineWidth].max
					lineWidth = 0
			end
		end
		result[:width] = [result[:width], lineWidth].max

		return result
	end
	
	# Convert string to a series of a formatting commands
	def self.tokenize(str, maxWidth)
		result = []

		# first tokenization pass - split texts and color formatting commands */
		offset = 0
		str.gsub(RE_COLORS) do |e|
			# string before */
			part = str[offset, str.index(e)-offset]
			#puts "offset: #{offset} Index: #{str.index(e)} result: #{part}"
			if (part.length > 0) 
				result.push({
					type: TYPE_TEXT,
					value: part
				})
			end
			
			# color command */
			result.push({
				type: (e[1] == "c" ? TYPE_FG : TYPE_BG),
				value: e[3, e.length-4]
			})

			offset = str.index(e) + e.length;
		end

		#/* last remaining part */
		part = str[offset, str.length-offset];
		if (part.length > 0) 
			result.push({
				type: TYPE_TEXT,
				value: part
			})
		end

		return self.breakLines(result, maxWidth)
	end
	
		private
		
	#/* insert line breaks into first-pass tokenized data */
	def self.breakLines(tokens, maxWidth)
		if (!maxWidth) 
			maxWidth = Float::INFINITY 
		end

		i = 0
		lineLength = 0
		lastTokenWithSpace = -1

		while (i < tokens.length)  #/* take all text tokens, remove space, apply linebreaks */
			token = tokens[i]
			if (token[:type] == TYPE_NEWLINE)  #/* reset */
				lineLength = 0;
				lastTokenWithSpace = -1
			end
			if (token[:type] != TYPE_TEXT)  #/* skip non-text tokens */
				i += 1
				next
			end

			#/* remove spaces at the beginning of line */
			while (lineLength == 0 && token[:value][0] == " ") 
				token[:value] = token[:value][1, token[:value].length]
			end

			#/* forced newline? insert two new tokens after self one */
			index = token[:value].index("\n")
			if (index != nil) 
				token[:value] = self.breakInsideToken(tokens, i, index, true)

				#/* if there are spaces at the end, we must remove them (we do not want the line too long) */
				arr = token[:value].split("")
				while (arr[arr.length-1] == " ")
					arr.pop()
				end
				token[:value] = arr.join("")
			end

			#/* token degenerated? */
			#puts "tokenkiller: #{tokens}"
			if (token[:value] == nil) 
				tokens.delete_at(i)
				next
			end

			if (lineLength + token[:value].length > maxWidth)  #/* line too long, find a suitable breaking spot */

				#/* is it possible to break within this token? */
				index = -1
				while (1) 
					nextIndex = token[:value].index(" ", index+1)
					if (nextIndex == nil) 
						break
					end
					if (lineLength + nextIndex > maxWidth) 
						break
					end
					index = nextIndex
				end

				if (index != -1) #* break at space within this one */
					token[:value] = self.breakInsideToken(tokens, i, index, true)
				elsif (lastTokenWithSpace != -1)  # /* is there a previous token where a break can occur? */l
					token = tokens[lastTokenWithSpace]
					breakIndex = token[:value].rindex(" ")
					token[:value] = self.breakInsideToken(tokens, lastTokenWithSpace, breakIndex, true)
					i = lastTokenWithSpace
				else  #/* force break in self token */
					token[:value] = self.breakInsideToken(tokens, i, maxWidth-lineLength, false)
				end

			else # /* line not long, continue */
				lineLength += token[:value].length
				if (token[:value].index(" ") != nil) 
					lastTokenWithSpace = i
				end
			end
			
			i += 1  #/* advance to next token */
		end


		tokens.push({type: TYPE_NEWLINE}) #/* insert fake newline to fix the last text line */
		#puts "tokens before: #{tokens}"
		#/* remove trailing space from text tokens before newlines */
		lastTextToken = nil
		for i in 0..tokens.length-1
			token = tokens[i]
			#puts "token: #{token} lastTextToken: #{lastTextToken}"
			case (token[:type])
				when TYPE_TEXT 
					lastTextToken = token 

				when TYPE_NEWLINE
					if (lastTextToken != nil) # /* remove trailing space */
						#puts "lastTextToken: #{lastTextToken}"
						arr = lastTextToken[:value].split("")
						while (arr[arr.length-1] == " ") 
						 	arr.pop()
						end
						lastTextToken[:value] = arr.join("")
					end
					lastTextToken = nil

			end
		end

		tokens.pop() #/* remove fake token */

		return tokens
	end

	def self.breakInsideToken(tokens, tokenIndex, breakIndex, removeBreakChar)
		#puts "Entered breakInsideToken"
		newBreakToken = {
			type: TYPE_NEWLINE
		}
		newTextToken = {
			type: TYPE_TEXT,
			value: tokens[tokenIndex][:value][breakIndex + (removeBreakChar ? 1 : 0), tokens[tokenIndex][:value].length - breakIndex]
		}
		#puts "newBreakToken: #{newBreakToken} newTextToken: #{newTextToken}"
		tokens[tokenIndex+1, 0] = [newBreakToken, newTextToken]
		#puts "Ending breakInsideToken"
		return tokens[tokenIndex][:value][0, breakIndex]
	end
end
