describe "Map.Dungeon" do
	names = ["Digger", "Uniform"]

	buildDungeonTests = function(name) {
		ctor = RotRails::Map[name]
		RotRails::RNG.setSeed(1234)
		map = new ctor()
		map.create()
		rooms = map.getRooms()
		corridors = map.getCorridors()

		describe(name do
			it "should generate >0 rooms" do
				expect(rooms.length).to be > (0)
			end

			it "all rooms should have at least one door" do
				for i in 0..rooms.length-1
					room = rooms[i]
					doorCount = 0
					room.create(function(x, y, value) {
						if (value == 2) { doorCount++ }
					})
					expect(doorCount).to be > (0)
				end
			end

			it "all rooms should have at least one wall" do
				for (i=0i<rooms.lengthi++) {
					room = rooms[i]
					wallCount = 0
					room.create(function(x, y, value) {
						if (value == 1) { wallCount++ }
					})
					expect(wallCount).to be > (0)
				end
			end

			it "all rooms should have at least one empty cell" do
				for (i=0i<rooms.lengthi++) {
					room = rooms[i]
					emptyCount = 0
					room.create(function(x, y, value) {
						if (value == 0) { emptyCount++ }
					})
					expect(emptyCount).to be > (0)
				end
			end

			it "should generate >0 corridors" do
				expect(corridors.length).to be > (0)
			end

			it "all corridors should have at least one empty cell" do
				for (i=0i<corridors.lengthi++) {
					corridor = corridors[i]
					emptyCount = 0
					corridor.create(function(x, y, value) {
						if (value == 0) { emptyCount++ }
					})
					expect(emptyCount).to be > (0)
				end
			end
		end
	end

	while (names.length > 0)
		name = names.shift()
		buildDungeonTests(name)
	end
end