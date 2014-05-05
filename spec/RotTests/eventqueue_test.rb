require "rotrails"

describe "EventQueue" do
	it "should return added event" do
		q = RotRails::EventQueue.new
		q.add("a", 100)
		expect(q.get()).to eq ("a")
	end

	it "should return nil when no events are available" do
		q = RotRails::EventQueue.new
		expect(q.get()).to eq (nil)
	end

	it "should remove returned events" do
		q = RotRails::EventQueue.new
		q.add(0, 0)
		q.get()
		expect(q.get()).to eq (nil)
	end

	it "should remove events" do
		q = RotRails::EventQueue.new
		q.add(123, 0)
		q.add(456, 0)
		result = q.remove(123)
		expect(result).to eq (true)
		expect(q.get()).to eq (456)
	end

	it "should survive removal of non-existant events" do
		q = RotRails::EventQueue.new
		q.add(0, 0)
		result = q.remove(1)
		expect(result).to eq (false)
		expect(q.get()).to eq (0)
	end

	it "should return events sorted" do
		q = RotRails::EventQueue.new
		q.add(456, 10)
		q.add(123, 5)
		q.add(789, 15)
		expect(q.get()).to eq (123)
		expect(q.get()).to eq (456)
		expect(q.get()).to eq (789)
	end

	it "should compute elapsed time" do
		q = RotRails::EventQueue.new
		q.add(456, 10)
		q.add(123, 5)
		q.add(789, 15)
		q.get()
		q.get()
		q.get()
		expect(q.getTime()).to eq (15)
	end

	it "should maintain event order for same timestamps" do
		q = RotRails::EventQueue.new
		q.add(456, 10)
		q.add(123, 10)
		q.add(789, 10)
		expect(q.get()).to eq (456)
		expect(q.get()).to eq (123)
		expect(q.get()).to eq (789)
		expect(q.getTime()).to eq (10)
	end
end