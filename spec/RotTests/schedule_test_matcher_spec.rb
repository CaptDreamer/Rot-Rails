require 'rspec/expectations'

RSpec::Matchers.define :toSchedule do |expected|		
	match do |actual|
		actual == expected
	end
	failure_message_for_should do |actual|
		notText = defined?(self.isNot) ? " not" : ""
		expected = expected.to_s
		"Expected #{actual} #{notText} to be scheduled as #{expected}"
	end
end
