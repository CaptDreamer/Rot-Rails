# require "for_test_helper"

# describe "FOV" do
# 	MAP8_RING0 = [
# 		"#####",
# 		"#####",
# 		"##@##",
# 		"#####",
# 		"#####"
# 	]

# 	RESULT_MAP8_RING0 = [
# 		"     ",
# 		" ... ",
# 		" ... ",
# 		" ... ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_90_NORTH = [
# 		"     ",
# 		" ... ",
# 		"  .  ",
# 		"     ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_90_SOUTH = [
# 		"     ",
# 		"     ",
# 		"  .  ",
# 		" ... ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_90_EAST = [
# 		"     ",
# 		"   . ",
# 		"  .. ",
# 		"   . ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_90_WEST = [
# 		"     ",
# 		" .   ",
# 		" ..  ",
# 		" .   ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_180_NORTH = [
# 		"     ",
# 		" ... ",
# 		" ... ",
# 		"     ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_180_SOUTH = [
# 		"     ",
# 		"     ",
# 		" ... ",
# 		" ... ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_180_EAST = [
# 		"     ",
# 		"  .. ",
# 		"  .. ",
# 		"  .. ",
# 		"     "
# 	]

# 	RESULT_MAP8_RING0_180_WEST = [
# 		"     ",
# 		" ..  ",
# 		" ..  ",
# 		" ..  ",
# 		"     "
# 	]

# 	MAP8_RING1 = [
# 		"#####",
# 		"#...#",
# 		"#.@.#",
# 		"#...#",
# 		"#####"
# 	]

# 	RESULT_MAP8_RING1 = [
# 		".....",
# 		".....",
# 		".....",
# 		".....",
# 		"....."
# 	]

# 	describe "Discrete Shadowcasting" do
# 		describe "8-topology" do
# 			it "should compute visible ring0" do
# 				lightPasses = buildLightCallback(MAP8_RING0)
# 				fov = new RotRails::FOV.DiscreteShadowcasting(lightPasses, {topology:8})
# 				checkResult(fov, lightPasses.center, RESULT_MAP8_RING0)
# 			end
# 			it "should compute visible ring1" do
# 				lightPasses = buildLightCallback(MAP8_RING1)
# 				fov = new RotRails::FOV.DiscreteShadowcasting(lightPasses, {topology:8})
# 				checkResult(fov, lightPasses.center, RESULT_MAP8_RING1)
# 			end
# 		end
# 	end

# 	describe "Precise Shadowcasting" do
# 		describe "8-topology" do
# 			it "should compute visible ring0" do
# 				lightPasses = buildLightCallback(MAP8_RING0)
# 				fov = new RotRails::FOV.PreciseShadowcasting(lightPasses, {topology:8})
# 				checkResult(fov, lightPasses.center, RESULT_MAP8_RING0)
# 			end
# 			it "should compute visible ring1" do
# 				lightPasses = buildLightCallback(MAP8_RING1)
# 				fov = new RotRails::FOV.PreciseShadowcasting(lightPasses, {topology:8})
# 				checkResult(fov, lightPasses.center, RESULT_MAP8_RING1)
# 			end
# 		end
# 	end

# 	describe "Recursive Shadowcasting" do
# 		describe "8-topology" do
# 			describe "360-degree view" do
# 				it "should compute visible ring0 in 360 degrees" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult(fov, lightPasses.center, RESULT_MAP8_RING0)
# 				end
# 				it "should compute visible ring1 in 360 degrees" do
# 					lightPasses = buildLightCallback(MAP8_RING1)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult(fov, lightPasses.center, RESULT_MAP8_RING1)
# 				end
# 			end
# 			describe "180-degree view" do
# 				it "should compute visible ring0 180 degrees facing north" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult180Degrees(fov, 0, lightPasses.center, RESULT_MAP8_RING0_180_NORTH)
# 				end
# 				it "should compute visible ring0 180 degrees facing south" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult180Degrees(fov, 4, lightPasses.center, RESULT_MAP8_RING0_180_SOUTH)
# 				end
# 				it "should compute visible ring0 180 degrees facing east" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult180Degrees(fov, 2, lightPasses.center, RESULT_MAP8_RING0_180_EAST)
# 				end
# 				it "should compute visible ring0 180 degrees facing west" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult180Degrees(fov, 6, lightPasses.center, RESULT_MAP8_RING0_180_WEST)
# 				end
# 			end
# 			describe "90-degree view" do
# 				it "should compute visible ring0 90 degrees facing north" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult90Degrees(fov, 0, lightPasses.center, RESULT_MAP8_RING0_90_NORTH)
# 				end
# 				it "should compute visible ring0 90 degrees facing south" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult90Degrees(fov, 4, lightPasses.center, RESULT_MAP8_RING0_90_SOUTH)
# 				end
# 				it "should compute visible ring0 90 degrees facing east" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult90Degrees(fov, 2, lightPasses.center, RESULT_MAP8_RING0_90_EAST)
# 				end
# 				it "should compute visible ring0 90 degrees facing west" do
# 					lightPasses = buildLightCallback(MAP8_RING0)
# 					fov = new RotRails::FOV.RecursiveShadowcasting(lightPasses, {topology:8})
# 					checkResult90Degrees(fov, 6, lightPasses.center, RESULT_MAP8_RING0_90_WEST)
# 				end
# 			end
# 		end
# 	end
# end # /* FOV */