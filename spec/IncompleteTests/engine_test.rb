# describe "Engine" do
# 	@RESULT = 0
# 	@E = null
# 	@S = null
# 	@A50 = {getSpeed: function() { return 50 }, act: function() { @RESULT++ } }
# 	@A70 = {getSpeed: function() { return 70 }, act: function() { @RESULT++ @S.add(@A100) } }
# 	@A100 = {getSpeed: function() { return 100 }, act: function() { @E.lock() } }

# 	beforeEach(function() {
# 		@RESULT = 0
# 		@S = new RotRails::Scheduler.Speed()
# 		@E = new RotRails::Engine(S)
# 	end

# 	it "should stop when locked" do
# 		@S.add(@A50, true)
# 		@S.add(@A100, true)

# 		@E.start()
# 		expect(@RESULT).toEqual(0)
# 	end

# 	it "should run until locked" do
# 		@S.add(@A50, true)
# 		@S.add(@A70, true)

# 		@E.start()
# 		expect(@RESULT).toEqual(2)
# 	end

# 	it "should run only when unlocked" do
# 		@S.add(@A70, true)

# 		@E.lock()
# 		@E.start()
# 		expect(@RESULT).toEqual(0)
# 		@E.start()
# 		expect(@RESULT).toEqual(1)
# 	end
# end