# require "display_test_helper"

# describe "Display" do
# 	describe "eventToPosition" do
# 		describe "rectangular layout" do
# 			it "should compute inside canvas" do
# 				d = new RotRails::Display({width:10, height:10})
# 				appendToBody(d)
# 				node = d.getContainer()
# 				cellW = node.offsetWidth/10
# 				cellH = node.offsetHeight/10
# 				e = {clientX: 100 + 1.5*cellW, clientY: 100 + 2.5*cellH}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (1)
# 				expect(pos[1]).to eq (2)				
# 				unlink(d)
# 			end
# 			it "should work with touch events as well" do
# 				d = new RotRails::Display({width:10, height:10})
# 				appendToBody(d)
# 				node = d.getContainer()
# 				cellW = node.offsetWidth/10
# 				cellH = node.offsetHeight/10
# 				touch1 = {clientX: 100 + 1.5*cellW, clientY: 100 + 2.5*cellH}
# 				touch2 = {clientX: 0, clientY: 0}
# 				e = {touches:[touch1, touch2]}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (1)
# 				expect(pos[1]).to eq (2)				
# 				unlink(d)
# 			end
# 			it "should fail outside of canvas (left top)" do
# 				d = new RotRails::Display({width:10, height:10})
# 				appendToBody(d)
# 				e = {clientX: 10, clientY: 10}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (-1)
# 				expect(pos[1]).to eq (-1)				
# 				unlink(d)
# 			end
# 			it "should fail outside of canvas (right bottom)" do
# 				d = new RotRails::Display({width:10, height:10})
# 				appendToBody(d)
# 				e = {clientX: 1000, clientY: 1000}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (-1)
# 				expect(pos[1]).to eq (-1)				
# 				unlink(d)
# 			end
# 		end

# 		describe "hex layout" do
# 			it "should compute inside canvas - odd row" do
# 				d = new RotRails::Display({width:10, height:10, layout:"hex"})
# 				appendToBody(d)
# 				node = d.getContainer()
# 				cellH = node.offsetHeight/10
# 				cellW = node.offsetWidth/5.5
# 				e = {clientX: 100 + 1.5*cellW, clientY: 100 + 2.5*cellH}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (2)
# 				expect(pos[1]).to eq (2)
# 				unlink(d)
# 			end
# 			it "should compute inside canvas - even row" do
# 				d = new RotRails::Display({width:10, height:10, layout:"hex"})
# 				appendToBody(d)
# 				node = d.getContainer()
# 				cellH = node.offsetHeight/10
# 				cellW = node.offsetWidth/5.5
# 				e = {clientX: 100 + 1*cellW, clientY: 100 + 1.5*cellH}
# 				pos = d.eventToPosition(e)
# 				expect(pos[0]).to eq (1)
# 				expect(pos[1]).to eq (1)
# 				unlink(d)
# 			end
# 		end
# 	end

# 	describe "drawText" do
# 		it "should provide default maxWidth" do
# 			d = new RotRails::Display({width:10, height:10})
# 			lines = d.drawText(7, 0, "aaaaaa")
# 			expect(lines).to eq (2)
# 		end
# 	end

# 	describe "computeSize" do
# 		describe "rectangular layout" do
# 			d1 = new RotRails::Display({fontSize:18, spacing:1})
# 			d2 = new RotRails::Display({fontSize:18, spacing:1.2})

# 			it "should compute integer size for spacing 1" do
# 				size = d1.computeSize(1/0, 180)
# 				expect(size[1]).to eq (10)
# 			end

# 			it "should compute fractional size for spacing 1" do
# 				size = d1.computeSize(1/0, 170)
# 				expect(size[1]).to eq (9)
# 			end

# 			it "should compute integer size for spacing >1" do
# 				size = d2.computeSize(1/0, 220)
# 				expect(size[1]).to eq (10)
# 			end

# 			it "should compute fractional size for spacing >1" do
# 				size = d2.computeSize(1/0, 210)
# 				expect(size[1]).to eq (9)
# 			end
# 		end

# 		describe "hex layout" do
# 			d1 = new RotRails::Display({fontSize:18, spacing:1, layout:"hex"})
# 			d2 = new RotRails::Display({fontSize:18, spacing:1.2, layout:"hex"})

# 			it "should compute size for spacing 1" do
# 				size = d1.computeSize(1/0, 96)
# 				expect(size[1]).to eq (5)
# 			end

# 			it "should compute size for spacing >1" do
# 				size = d2.computeSize(1/0, 96)
# 				expect(size[1]).to eq (4)
# 			end
# 		end

# 		describe "tile layout" do
# 			d = new RotRails::Display({layout:"tile", tileWidth:32, tileHeight:16})

# 			it "should compute proper size" do
# 				size = d.computeSize(200, 300)
# 				expect(size[0]).to eq (6)
# 				expect(size[1]).to eq (18)
# 			end
# 		end
# 	end

# 	describe "computeFontSize" do
# 		describe "rectangular layout" do
# 			d1 = new RotRails::Display({width:100, height:20, spacing:1})
# 			d2 = new RotRails::Display({width:100, height:20, spacing:1.2})

# 			it "should compute integer size for spacing 1" do
# 				size = d1.computeFontSize(1/0, 180)
# 				expect(size).to eq (9)
# 			end

# 			it "should compute fractional size for spacing 1" do
# 				size = d1.computeFontSize(1/0, 170)
# 				expect(size).to eq (8)
# 			end

# 			it "should compute integer size for spacing >1" do
# 				size = d2.computeFontSize(1/0, 180)
# 				expect(size).to eq (7)
# 			end

# 			it "should compute fractional size for spacing >1" do
# 				size = d2.computeFontSize(1/0, 170)
# 				expect(size).to eq (6)
# 			end
# 		end

# 		describe "hex layout" do
# 			d1 = new RotRails::Display({width:100, height:5, spacing:1, layout:"hex"})
# 			d2 = new RotRails::Display({width:100, height:5, spacing:1.3, layout:"hex"})
# 			window.d1 = d1

# 			it "should compute size for spacing 1" do
# 				size = d1.computeFontSize(1/0, 96)
# 				expect(size).to eq (19)
# 			end

# 			it "should compute size for spacing >1" do
# 				size = d2.computeFontSize(1/0, 96)
# 				expect(size).to eq (14)
# 			end
# 		end

# 		describe "tile layout" do
# 			d = new RotRails::Display({layout:"tile", width:6, height:18})

# 			it "should compute proper size" do
# 				size = d.computeFontSize(200, 300)
# 				expect(size[0]).to eq (33)
# 				expect(size[1]).to eq (16)
# 			end
# 		end
# 	end
# end