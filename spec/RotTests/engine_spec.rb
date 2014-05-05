describe "Engine" do
	@RESULT = 0
	@E = nil
	@S = nil

	before(:each) do	
		@RESULT = 0
		@S = RotRails::Scheduler::Speed.new
		@E = RotRails::Engine.new(@S)
		@E50 = {:getSpeed => Proc.new do 
					50 
				end, 
				:act => Proc.new do 
					@RESULT +=1 
				end 
				}
		@E100 = {:getSpeed => Proc.new do 
					100 
				end, 
				:act => Proc.new do 
					@E.lock() 
				end
				}
		@E70 = {:getSpeed => Proc.new do 
					70 
				end, 
				:act => Proc.new do 
					@RESULT +=1 
					@S.add(@E100, false)
				end 
				}
	end

	it "should stop when locked" do
		@S.add(@E50, true)
		@S.add(@E100, true)
		@E.start()
		expect(@RESULT).to eq (0)
	end

	it "should run until locked" do
		@S.add(@E50, true)
		@S.add(@E70, true)

		@E.start()
		expect(@RESULT).to eq(2)
	end

	it "should run only when unlocked" do
		@S.add(@E70, true)

		@E.lock()
		@E.start()
		expect(@RESULT).to eq (0)
		@E.start()
		expect(@RESULT).to eq (1)
	end
end