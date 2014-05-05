describe "Path" do
	# #*
	#  * ........
	#  * A###.###
	#  * ..B#.#X#
	#  * .###.###
	#  * ....Z...
	#  */
	MAP48 = [ ## transposed */
		[0, 0, 0, 0, 0],	
		[0, 1, 0, 1, 0],	
		[0, 1, 0, 1, 0],	
		[0, 1, 1, 1, 0],	
		[0, 0, 0, 0, 0],
		[0, 1, 1, 1, 0],
		[0, 1, 0, 1, 0],
		[0, 1, 1, 1, 0]
	]

	PASSABLE_CALLBACK_48 = function(x, y) {
		if (x<0 || y<0 || x>=MAP48.length || y>=MAP48[0].length) { return false }
		return (MAP48[x][y] == 0)
	}

	A = [0, 1]
	B = [2, 2]
	Z = [4, 4]
	X = [6, 2]
	PATH = []
	PATH_CALLBACK = function(x, y) { PATH.push(x, y) }

	# #
	#  * . . A # . B
	#  *  . # # . .
	#  * . . # . . .
	#  *  # . . # .
	#  * X # # # Z .
	#  */
	MAP6 = [ # transposed */
		[0, null, 0, null, 0],
		[null, 0, null, 1, null],
		[0, null, 0, null, 1],
		[null, 1, null, 0, null],
		[0, null, 1, null, 1],
		[null, 1, null, 0, null],
		[1, null, 0, null, 1],
		[null, 0, null, 1, null],
		[0, null, 0, null, 0],
		[null, 0, null, 0, null],
		[0, null, 0, null, 0]
	]

	A6 = [4, 0]
	B6 = [10, 0]
	Z6 = [8, 4]
	X6 = [0, 4]

	PASSABLE_CALLBACK_6 = function(x, y) {
		if (x<0 || y<0 || x>=MAP6.length || y>=MAP6[0].length) { return false }
		return (MAP6[x][y] == 0)
	}

	beforeEach(function() {
		PATH = []
	end


	describe "Dijkstra" do
		describe "8-topology" do
			PATH_A = [0, 1, 0, 2, 0, 3, 1, 4, 2, 4, 3, 4, 4, 4]
			PATH_B = [2, 2, 1, 2, 0, 3, 1, 4, 2, 4, 3, 4, 4, 4]
			dijkstra = new RotRails::Path.Dijkstra(Z[0], Z[1], PASSABLE_CALLBACK_48, {topology:8}

			it "should compute correct path A" do
				path = []
				dijkstra.compute(A[0], A[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				dijkstra.compute(B[0], B[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				dijkstra.compute(X[0], X[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end # 8-topology */

		describe "4-topology" do
			PATH_A = [0, 1, 0, 2, 0, 3, 0, 4, 1, 4, 2, 4, 3, 4, 4, 4]
			PATH_B = [2, 2, 1, 2, 0, 2, 0, 3, 0, 4, 1, 4, 2, 4, 3, 4, 4, 4]
			dijkstra = new RotRails::Path.Dijkstra(Z[0], Z[1], PASSABLE_CALLBACK_48, {topology:4}

			it "should compute correct path A" do
				dijkstra.compute(A[0], A[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				dijkstra.compute(B[0], B[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				dijkstra.compute(X[0], X[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end # 4-topology */

		describe "6-topology" do
			PATH_A = [4, 0, 2, 0, 1, 1, 2, 2, 3, 3, 5, 3, 6, 2, 8, 2, 9, 3, 8, 4]
			PATH_B = [10, 0, 9, 1, 8, 2, 9, 3, 8, 4]
			dijkstra = new RotRails::Path.Dijkstra(Z6[0], Z6[1], PASSABLE_CALLBACK_6, {topology:6}

			it "should compute correct path A" do
				dijkstra.compute(A6[0], A6[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				dijkstra.compute(B6[0], B6[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				dijkstra.compute(X6[0], X6[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end # 6-topology */

	end # dijkstra */

	describe "A*" do
		describe "8-topology" do
			PATH_A = [0, 1, 0, 2, 0, 3, 1, 4, 2, 4, 3, 4, 4, 4]
			PATH_B = [2, 2, 1, 2, 0, 3, 1, 4, 2, 4, 3, 4, 4, 4]
			astar = new RotRails::Path.AStar(Z[0], Z[1], PASSABLE_CALLBACK_48, {topology:8}

			it "should compute correct path A" do
				path = []
				astar.compute(A[0], A[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				astar.compute(B[0], B[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				astar.compute(X[0], X[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end # 8-topology */

		describe "4-topology" do
			PATH_A = [0, 1, 0, 2, 0, 3, 0, 4, 1, 4, 2, 4, 3, 4, 4, 4]
			PATH_B = [2, 2, 1, 2, 0, 2, 0, 3, 0, 4, 1, 4, 2, 4, 3, 4, 4, 4]
			astar = new RotRails::Path.AStar(Z[0], Z[1], PASSABLE_CALLBACK_48, {topology:4}

			it "should compute correct path A" do
				astar.compute(A[0], A[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				astar.compute(B[0], B[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				astar.compute(X[0], X[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end # 4-topology */

		describe "6-topology" do
			PATH_A = [4, 0, 2, 0, 1, 1, 2, 2, 3, 3, 5, 3, 6, 2, 8, 2, 9, 3, 8, 4]
			PATH_B = [10, 0, 9, 1, 8, 2, 9, 3, 8, 4]
			astar = new RotRails::Path.AStar(Z6[0], Z6[1], PASSABLE_CALLBACK_6, {topology:6}

			it "should compute correct path A" do
				astar.compute(A6[0], A6[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_A.toString())
			end

			it "should compute correct path B" do
				astar.compute(B6[0], B6[1], PATH_CALLBACK)
				expect(PATH.toString()).toEqual(PATH_B.toString())
			end

			it "should survive non-existant path X" do
				astar.compute(X6[0], X6[1], PATH_CALLBACK)
				expect(PATH.length).toEqual(0)
			end
		end ## 6-topology */

	end ## A* */

end ## path */