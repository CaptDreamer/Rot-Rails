require 'spec_helper'

describe "Color" do
	describe "add" do
		it "should add two colors" do
			expect(RotRails::Color.add([1,2,3], [3,4,5])).to eq ([4,6,8])
		end
		it "should add three colors" do
			expect(RotRails::Color.add([1,2,3], [3,4,5], [100,200,300])).to eq ([104,206,308])
		end
		it "should add one color (noop)" do
			expect(RotRails::Color.add([1,2,3])).to eq ([1,2,3])
		end

		it "should not modify first argument values" do
			c1 = [1,2,3]
			c2 = [3,4,5]
			RotRails::Color.add(c1, c2)
			expect(c1).to eq ([1,2,3])
		end
	end

	describe "add_" do
		it "should add two colors" do
			expect(RotRails::Color.add_([1,2,3], [3,4,5])).to eq ([4,6,8])
		end
		it "should add three colors" do
			expect(RotRails::Color.add_([1,2,3], [3,4,5], [100,200,300])).to eq ([104,206,308])
		end
		it "should add one color (noop)" do
			expect(RotRails::Color.add_([1,2,3])).to eq ([1,2,3])
		end

		it "should modify first argument values" do
			c1 = [1,2,3]
			c2 = [3,4,5]
			RotRails::Color.add_(c1, c2)
			expect(c1).to eq ([4,6,8])
		end
		it "should return first argument" do
			c1 = [1,2,3]
			c2 = [3,4,5]
			c3 = RotRails::Color.add_(c1, c2)
			expect(c1).to eq (c3)
		end
	end

	describe "multiply" do
		it "should multiply two colors" do
			expect(RotRails::Color.multiply([100,200,300], [51,51,51])).to eq ([20,40,60])
		end
		it "should multiply three colors" do
			expect(RotRails::Color.multiply([100,200,300], [51,51,51], [510,510,510])).to eq ([40,80,120])
		end
		it "should multiply one color (noop)" do
			expect(RotRails::Color.multiply([1,2,3])).to eq ([1,2,3])
		end
		it "should not modify first argument values" do
			c1 = [1,2,3]
			c2 = [3,4,5]
			RotRails::Color.multiply(c1, c2)
			expect(c1).to eq ([1,2,3])
		end
		it "should round values" do
			expect(RotRails::Color.multiply([100,200,300], [10, 10, 10])).to eq ([4,8,12])
		end
	end

	describe "multiply_" do
		it "should multiply two colors" do
			expect(RotRails::Color.multiply_([100,200,300], [51,51,51])).to eq ([20,40,60])
		end
		it "should multiply three colors" do
			expect(RotRails::Color.multiply_([100,200,300], [51,51,51], [510,510,510])).to eq ([40,80,120])
		end
		it "should multiply one color (noop)" do
			expect(RotRails::Color.multiply_([1,2,3])).to eq ([1,2,3])
		end
		it "should modify first argument values" do
			c1 = [100,200,300]
			c2 = [51,51,51]
			RotRails::Color.multiply_(c1, c2)
			expect(c1).to eq ([20,40,60])
		end
		it "should round values" do
			expect(RotRails::Color.multiply_([100,200,300], [10, 10, 10])).to eq ([4,8,12])
		end
		it "should return first argument" do
			c1 = [1,2,3]
			c2 = [3,4,5]
			c3 = RotRails::Color.multiply_(c1, c2)
			expect(c1).to eq (c3)
		end
	end

	describe "fromString" do
		it "should handle rgb() colors" do
			expect(RotRails::Color.fromString("rgb(10, 20, 33)")).to eq ([10, 20, 33])
		end
		it "should handle #abcdef colors" do
			expect(RotRails::Color.fromString("#1a2f3c")).to eq ([26, 47, 60])
		end
		it "should handle #abc colors" do
			expect(RotRails::Color.fromString("#ca8")).to eq ([204, 170, 136])
		end
		it "should handle named colors" do
			expect(RotRails::Color.fromString("red")).to eq ([255, 0, 0])
		end
		it "should not handle nonexistant colors" do
			expect(RotRails::Color.fromString("lol")).to eq ([0, 0, 0])
		end
	end

	describe "toRGB" do
		it "should serialize to rgb" do
			expect(RotRails::Color.toRGB([10, 20, 30])).to eq ("rgb(10,20,30)")
		end
		it "should clamp values to 0..255" do
			expect(RotRails::Color.toRGB([-100, 20, 2000])).to eq ("rgb(0,20,255)")
		end
	end

	describe "toHex" do
		it "should serialize to hex" do
			expect(RotRails::Color.toHex([10, 20, 40])).to eq ("#0a1428")
		end
		it "should clamp values to 0..255" do
			expect(RotRails::Color.toHex([-100, 20, 2000])).to eq ("#0014ff")
		end
	end

	describe "interpolate" do
		it "should intepolate two colors" do
			expect(RotRails::Color.interpolate([10, 20, 40], [100, 200, 300], 0.1)).to eq ([19, 38, 66])
		end
		it "should round values" do
			expect(RotRails::Color.interpolate([10, 20, 40], [15, 30, 53], 0.5)).to eq ([13, 25, 47])
		end
		it "should default to 0.5 factor" do
			expect(RotRails::Color.interpolate([10, 20, 40], [20, 30, 40])).to eq ([15, 25, 40])
		end
	end

	describe "interpolateHSL" do
		it "should intepolate two colors" do
			expect(RotRails::Color.interpolateHSL([10, 20, 40], [100, 200, 300], 0.1)).to eq ([12, 33, 73])
		end
	end

	describe "randomize" do
		it "should maintain constant diff when a number is used" do
			c = RotRails::Color.randomize([100, 100, 100], 100)
			expect(c[0]).to eq (c[1])
			expect(c[1]).to eq (c[2])
		end
	end

	describe "rgb2hsl and hsl2rgb" do
		it "should correctly convert to HSL and back" do
			rgb = [
				[255, 255, 255],
				[0, 0, 0],
				[255, 0, 0],
				[30, 30, 30],
				[100, 120, 140]
			]

			while (rgb.length > 0) do
				color = rgb.pop()
				hsl = RotRails::Color.rgb2hsl(color)
				rgb2 = RotRails::Color.hsl2rgb(hsl)
				expect(rgb2).to eq (color)
			end
		end

		it "should round converted values" do
			hsl = [0.5, 0, 0.3]
			rgb = RotRails::Color.hsl2rgb(hsl)
			for i in 0..rgb.length-1 
				expect(rgb[i].round).to eq (rgb[i])
			end
		end
	end
end