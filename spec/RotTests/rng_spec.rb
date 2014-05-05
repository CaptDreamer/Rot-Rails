require 'spec_helper'

describe "RNG" do
	describe "getUniform" do
		before do
			@value = RotRails::RNG.getUniform()
		end
		it "should return a number" do
			expect((@value).kind_of?(Float)).to eq true
		end
		it "should return a number 0..1" do
			expect(@value).to be > (0)
			expect(@value).to be < (1)
		end
	end

	describe "getUniformInt" do
		before do
			@lowerBound = 5
			@upperBound = 10
		end
		it "should return a number" do
		    @value = RotRails::RNG.getUniformInt(@lowerBound, @upperBound)
			expect((@value).kind_of?(Integer)).to eq true
		end
		it "should not care which number is larger in the arguments" do
			seed = (Random.rand(100000)*1000000).round
			RotRails::RNG.setSeed(seed)
			val1 = RotRails::RNG.getUniformInt(@lowerBound, @upperBound)
			RotRails::RNG.setSeed(seed)
			val2 = RotRails::RNG.getUniformInt(@upperBound, @lowerBound)
			expect(val1).to eq (val2)
		end
		it "should only return a number in the desired range" do
			value = RotRails::RNG.getUniformInt(@lowerBound, @upperBound)
			value2 = RotRails::RNG.getUniformInt(@upperBound, @lowerBound)
			expect(value).to_not be > (@upperBound)
			expect(value).to_not be < (@lowerBound)
			expect(value2).to_not be > (@upperBound)
			expect(value2).to_not be < (@lowerBound)
		end
	end

	describe "seeding" do
		it "should return a seed number" do
			expect((RotRails::RNG.getSeed()).kind_of?(Integer)).to eq true
		end

		it "should return the same value for a given seed" do
			seed = (Random.rand(100000)*1000000).round
			RotRails::RNG.setSeed(seed)
			val1 = RotRails::RNG.getUniform()
			RotRails::RNG.setSeed(seed)
			val2 = RotRails::RNG.getUniform()
			expect(val1).to eq (val2)
		end

		it "should return a precomputed value for a given seed" do
			RotRails::RNG.setSeed(12345)
			val = RotRails::RNG.getUniform()
			expect(val).to eq (0.01198604702949524)
		end
	end

	describe "state manipulation" do
		it "should return identical values after setting identical states" do
			RotRails::RNG.getUniform()

			state = RotRails::RNG.getState()
			val1 = RotRails::RNG.getUniform()
			RotRails::RNG.setState(state)
			val2 = RotRails::RNG.getUniform()

			expect(val1).to eq (val2)
		end
	end

end