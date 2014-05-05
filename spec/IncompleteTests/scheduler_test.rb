describe "Scheduler" do
		before.each 

	{
		this.addMatchers({
			toSchedule: function(expected) {
				this.message = function() {
					notText = this.isNot ? " not" : ""
					actual = this.actual.map(JSON.stringify)
					expected = expected.map(JSON.stringify)
					return "Expected " + actual + notText + " to be scheduled as " + expected
				}
				for (i=0i<Math.max(expected.length, this.actual.length)i++) {
					if (this.actual[i] !== expected[i]) { return false }
				}
				return true
			}
		end
	end

	describe "Simple" do
		S = new RotRails::Scheduler.Simple()
		A1 = "A1"
		A2 = "A2"
		A3 = "A3"
		before.each
			S.clear() 
		end

		it("should schedule actors evenly" do
			S.add(A1, true)
			S.add(A2, true)
			S.add(A3, true)
			result = []
			for (i=0i<6i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A2, A3, A1, A2, A3])
		end

		it("should schedule one-time events" do
			S.add(A1, false)
			S.add(A2, true)
			result = []
			for (i=0i<4i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A2, A2, A2])
		end

		it("should remove repeated events" do
			S.add(A1, false)
			S.add(A2, true)
			S.add(A3, true)
			S.remove(A2)
			result = []
			for (i=0i<4i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A3, A3, A3])
		end

		it("should remove one-time events" do
			S.add(A1, false)
			S.add(A2, false)
			S.add(A3, true)
			S.remove(A2)
			result = []
			for (i=0i<4i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A3, A3, A3])
		end

	end

	describe "Speed" do
		S = new RotRails::Scheduler.Speed()
		A = {getSpeed:function(){return this.speed}}
		A50 = Object.create(A) A50.speed = 50
		A100a = Object.create(A) A100a.speed = 100
		A100b = Object.create(A) A100b.speed = 100
		A200 = Object.create(A) A200.speed = 200

		before.each 
			{ S.clear() 
		end

		it("should schedule same speed evenly" do
			S.add(A100a, true)
			S.add(A100b, true)
			result = []
			for (i=0i<4i++) { result.push(S.next()) }

			expect(result).toSchedule([A100a, A100b, A100a, A100b])
		end

		it("should schedule different speeds properly" do
			S.add(A50, true)
			S.add(A100a, true)
			S.add(A200, true)
			result = []
			for (i=0i<7i++) { result.push(S.next()) }
			expect(result).toSchedule([A200, A100a, A200, A200, A50, A100a, A200])
		end
	end

	describe "Action" do
		S = null
		A1 = "A1"
		A2 = "A2"
		A3 = "A3"
		before.each 
			{ S = new RotRails::Scheduler.Action() 
		end

		it("should schedule evenly by default" do
			S.add(A1, true)
			S.add(A2, true)
			S.add(A3, true)
			result = []
			for (i=0i<6i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A2, A3, A1, A2, A3])
		end

		it("should schedule with respect to extra argument" do
			S.add(A1, true)
			S.add(A2, true, 2)
			S.add(A3, true)
			result = []
			for (i=0i<6i++) { result.push(S.next()) }
			expect(result).toSchedule([A1, A3, A2, A1, A3, A2])
		end

		it("should schedule with respect to action duration" do
			S.add(A1, true)
			S.add(A2, true)
			S.add(A3, true)
			result = []

			result.push(S.next())
			S.setDuration(10)

			result.push(S.next())
			S.setDuration(5)

			result.push(S.next())
			S.setDuration(1)
			expect(S.getTime()).toEqual(1)

			for (i=0i<3i++) { 
				result.push(S.next()) 
				S.setDuration(100) /* somewhere in the future */
			}

			expect(result).toSchedule([A1, A2, A3, A3, A2, A1])
		end
	end
end