require 'pry'
fr = File.new('./test.txt')
fw = File.new('./test.rb','w+')
fw.print "translit_dim = ["
fr.each_line do |s|
	row = s.split	#("\t")
#	binding.pry
#	if row[1] != "" then
	fw.print ", [\"#{row[0]}\", \"#{row[1]}\"]"
#	else
#		fw.print ", [\"#{row[0]}\", \"#{row[2]}\"]"
#	end
end
fw.print "]"
fw.close
fr.close