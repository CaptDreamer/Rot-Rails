def buildLightCallback(map)
	center = [0, 0]
	#/* locate center */
	for j in 0..map.length-1
		for i in 0..map[j].length-1
			if (map[j][i] == "@")
				center = [i, j]
			end
		end
	end

	result.center = center
	return result
end

def checkResult(fov, center, result)
	used = {}
	callback = function(x, y, dist) {
		expect(result[y][x]).to eq (".")
		used[x+","+y] = 1
	}

	fov.compute(center[0], center[1], 2, callback)
	for (j=0j<result.lengthj++) {
		for (i=0i<result[j].lengthi++) {
			if (result[j][i] != ".") { continue }
			expect((i+","+j) in used).to eq (true)
		}
	}
}

checkResult90Degrees = function(fov, dir, center, result) {
	used = {}
	callback = function(x, y, dist) {
		expect(result[y][x]).to eq (".")
		used[x+","+y] = 1
	}

	fov.compute90(center[0], center[1], 2, dir, callback)
	for (j=0j<result.lengthj++) {
		for (i=0i<result[j].lengthi++) {
			if (result[j][i] != ".") { continue }
			expect((i+","+j) in used).to eq (true)
		}
	}
}

checkResult180Degrees = function(fov, dir, center, result) {
	used = {}
	callback = function(x, y, dist) {
		expect(result[y][x]).to eq (".")
		used[x+","+y] = 1
	}

	fov.compute180(center[0], center[1], 2, dir, callback)
	for (j=0j<result.lengthj++) {
		for (i=0i<result[j].lengthi++) {
			if (result[j][i] != ".") { continue }
			expect((i+","+j) in used).to eq (true)
		}
	}
}

private


def result(x, y)
	ch = map[y][x]
	return (ch != "#")
end