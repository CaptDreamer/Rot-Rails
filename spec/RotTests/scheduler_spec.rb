require_relative "schedule_test_matcher_spec"

describe "Scheduler" do

	describe "Simple" do
		before(:each) do
			@S = RotRails::Scheduler::Simple.new
			@SH1 = "@SH1"
			@SH2 = "@SH2"
			@SH3 = "@SH3"
			@S.clear() 
		end

		it "should schedule actors evenly" do
			@S.add(@SH1, true)
			@S.add(@SH2, true)
			@S.add(@SH3, true)
			result = []
			for i in 0..5
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH2, @SH3, @SH1, @SH2, @SH3])
		end

		it "should schedule one-time events" do
			@S.add(@SH1, false)
			@S.add(@SH2, true)
			result = []
			for i in 0..3
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH2, @SH2, @SH2])
		end

		it "should remove repeated events" do
			@S.add(@SH1, false)
			@S.add(@SH2, true)
			@S.add(@SH3, true)
			@S.remove(@SH2)
			result = []
			for i in 0..3
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH3, @SH3, @SH3])
		end

		it "should remove one-time events" do
			@S.add(@SH1, false)
			@S.add(@SH2, false)
			@S.add(@SH3, true)
			@S.remove(@SH2)
			result = []
			for i in 0..3
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH3, @SH3, @SH3])
		end

	end

	describe "Speed" do


		before(:each) do
			@S = RotRails::Scheduler::Speed.new
			@SH50 = {:getSpeed => Proc.new do 50 end }
			@SH100a = {:getSpeed => Proc.new do 100 end }
			@SH100b = {:getSpeed => Proc.new do 100 end }
			@SH200 = {:getSpeed => Proc.new do 200 end }
			@S.clear() 
		end

		it "should schedule same speed evenly" do
			@S.add(@SH100a, true)
			@S.add(@SH100b, true)
			result = []
			for i in 0..3
				result.push(@S.next())
			end

			expect(result).to toSchedule([@SH100a, @SH100b, @SH100a, @SH100b])
		end

		it "should schedule different speeds properly" do
			@S.add(@SH50, true)
			@S.add(@SH100a, true)
			@S.add(@SH200, true)
			result = []
			for i in 0..6
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH200, @SH100a, @SH200, @SH200, @SH50, @SH100a, @SH200])
		end
	end

	describe "Action" do
		before(:each) do
			@S = nil
			@SH1 = "@SH1"
			@SH2 = "@SH2"
			@SH3 = "@SH3"
			@S = RotRails::Scheduler::Action.new
		end

		it "should schedule evenly by default" do
			@S.add(@SH1, true)
			@S.add(@SH2, true)
			@S.add(@SH3, true)
			result = []
			for i in 0..5
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH2, @SH3, @SH1, @SH2, @SH3])
		end

		it "should schedule with respect to extra argument" do
			@S.add(@SH1, true)
			@S.add(@SH2, true, 2)
			@S.add(@SH3, true)
			result = []
			for i in 0..5
				result.push(@S.next())
			end
			expect(result).to toSchedule([@SH1, @SH3, @SH2, @SH1, @SH3, @SH2])
		end

		it "should schedule with respect to action duration" do
			@S.add(@SH1, true)
			@S.add(@SH2, true)
			@S.add(@SH3, true)
			result = []

			result.push(@S.next())
			@S.setDuration(10)

			result.push(@S.next())
			@S.setDuration(5)

			result.push(@S.next())
			@S.setDuration(1)
			expect(@S.getTime()).to eq (1)

			for i in 0..2 
				result.push(@S.next()) 
				@S.setDuration(100) #/* somewhere in the future */
			end

			expect(result).to toSchedule([@SH1, @SH2, @SH3, @SH3, @SH2, @SH1])
		end
	end
end