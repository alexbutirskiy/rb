require './library_class.rb'

describe Author, "class" do
	before :each do
		@empty = Author.new
		@tolstoy = Author.new("Leo Tolstoy", 1828, 1910)
		@matthew = Author.new("Levi Matthew"); @matthew.death_date = 74
		@king = Author.new("Stephen Even King"); @king.birth_date = 1947
	end

	context "#initialize" do

		it "sets to name default value \"Unknown Author\" when has been initialized without parametres" do
			expect(@empty.name).to eq "Unknown Author"
			expect(@empty.birth_date).to eq nil
			expect(@empty.death_date).to eq nil
		end
		it "sets proper values when has been initialized with parametres" do
			t = Author.new("Leo Tolstoy", 1828, 1910)
			expect(@tolstoy.name).to eq "Leo Tolstoy"
			expect(@tolstoy.birth_date).to eq 1828
			expect(@tolstoy.death_date).to eq 1910
		end

	end

	context "#to_s" do
		it "prduces string like: \"Leo Tolstoy (1828 - 1910)\" when all para is present" do
			expect(@tolstoy.to_s).to eq "Leo Tolstoy (1828 - 1910)"
		end
		it "prduces string like: \"Levi Matthew (??? - 74)\" when birth date is unknown" do
			expect(@matthew.to_s).to eq "Levi Matthew (??? - 74)"
		end
		it "prduces string like: \"Stephen Even King (1947)\" when author is still alive" do
			expect(@king.to_s).to eq "Stephen Even King (1947)"
		end
	end

	context "#eql?" do
		it "raise ArgumentError: when arg is absent" do
			expect {@tolstoy.eql?}.to raise_error(ArgumentError)
		end
		it "retuens false when objects are different" do
			expect(@tolstoy.eql? @metthew).to eq false
		end
		it "retuens false when arge isn't istance of Author" do
			expect(@tolstoy.eql? "Leo Tolstoy").to eq false
		end
		it "retuens true when both instances are empty (default)" do
			expect(@empty.eql? @empty).to eq true
		end
		it "retuens true when both instances are the same" do
			expect(@tolstoy.eql? @tolstoy).to eq true
		end
		it "retuens true when both instances are the same" do
			tolstoy2 = @tolstoy
			expect(@tolstoy.eql? tolstoy2).to eq true
		end
	end

	context "#==" do
		it "makes proper equal operation ==" do
			expect(@tolstoy.eql? @king).to eq false
		end
	end
	
end

describe Book, "class" do
	before :each do
		@tolstoy = Author.new("Leo Tolstoy", 1828, 1910)
		@matthew = Author.new("Levi Matthew"); @matthew.death_date = 74
		@king = Author.new("Stephen Even King"); @king.birth_date = 1947
		@empty = Book.new
		@bible = Book.new("Holy Bible", @matthew)
		@war = Book.new("War and Peace", @tolstoy)
	end

	context "#initialize" do
		it "sets to title default value \"No Title\" when has been initialized without parametres" do
			expect(@empty.title).to eq "No Title"
		end
		it "sets proper values when has been initialized with parametres" do
			expect(@bible.title).to eq "Holy Bible"
			expect(@bible.author).to eq @matthew
		end
	end

	context "#eql?" do
		it "raise ArgumentError: if no arg" do
			expect{@bible.eql?}.to raise_error(ArgumentError)
		end
		it "returns false when arg isn't Book class instance" do
			expect(@bible.eql? @matthew).to eq false
		end
		it "returns false when instances aren't equal" do
			expect(@bible.eql? @war).to eq false
		end
		it "returns true when both instances are the same" do
			expect(@bible.eql? @bible).to eq true
		end
		it "returns true when both instances are equal" do
			bible2 = @bible
			expect(@bible.eql? bible2).to eq true
		end
	end

	context "@==" do
		it "makes proper equal operation ==" do
			expect(@bile.eql? @war).to eq false
		end
	end

end