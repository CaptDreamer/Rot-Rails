require 'spec_helper'

describe "Text" do
	describe "line breaking" do
		A100 = "A" * 101
		B100 = "B" * 101

		it "should not break when not requested" do
			size = RotRails::Text.measure(A100, nil)
			expect(size[:width]).to eq (A100.length)
			expect(size[:height]).to eq (1)
		end

		it "should break when max length requested" do
			size = RotRails::Text.measure(A100, 30)
			expect(size[:height]).to eq (4)
		end

		it "should break at explicit newlines" do
			size = RotRails::Text.measure("a\nb\nc", nil)
			expect(size[:height]).to eq (3)
		end

		it "should break at explicit newlines AND max length" do
			size = RotRails::Text.measure(A100 + B100, 30)
			expect(size[:height]).to eq (7)

			size = RotRails::Text.measure(A100 + "\n" + B100, 30)
			expect(size[:height]).to eq (8)
		end

		it "should break at space" do
			size = RotRails::Text.measure(A100 + " " + B100, 30)
			expect(size[:height]).to eq (8)
		end

		it "should not break at nbsp" do
			size = RotRails::Text.measure(A100 + (160).chr + B100, 30)
			expect(size[:height]).to eq (7)
		end

		it "should not break when text is short" do
			size = RotRails::Text.measure("aaa bbb", 7)
			expect(size[:width]).to eq (7)
			expect(size[:height]).to eq (1)
		end

		it "should adjust resulting width" do
			size = RotRails::Text.measure("aaa bbb", 6)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (2)
		end

		it "should adjust resulting width even without breaks" do
			size = RotRails::Text.measure("aaa ", 6)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (1)
		end

		it "should remove unnecessary spaces around newlines" do
			size = RotRails::Text.measure("aaa  \n  bbb", nil)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (2)
		end

		it "should remove unnecessary spaces at the beginning" do
			size = RotRails::Text.measure("   aaa    bbb", 3)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (2)
		end

		it "should remove unnecessary spaces at the end" do
			size = RotRails::Text.measure("aaa    \nbbb", 3)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (2)
		end
	end

	describe "color formatting" do
		it "should not break with formatting part" do
			size = RotRails::Text.measure("aaa%c{x}bbb", nil)
			expect(size[:height]).to eq (1)
		end

		it "should correctly remove formatting" do
			size = RotRails::Text.measure("aaa%c{x}bbb", nil)
			expect(size[:width]).to eq (6)
		end

		it "should break independently on formatting - forced break" do
			size = RotRails::Text.measure("aaa%c{x}bbb", 3)
			expect(size[:width]).to eq (3)
			expect(size[:height]).to eq (2)
		end

		it "should break independently on formatting - forward break" do
			size = RotRails::Text.measure("aaa%c{x}b bb", 5)
			expect(size[:width]).to eq (4)
			expect(size[:height]).to eq (2)
		end

		it "should break independently on formatting - backward break" do
			size = RotRails::Text.measure("aa a%c{x}bbb", 5)
			expect(size[:width]).to eq (4)
			expect(size[:height]).to eq (2)
		end
	end
end
