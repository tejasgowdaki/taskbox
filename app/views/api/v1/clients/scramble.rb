def scramble(scr_word, com_word)
	scr_word = scr_word.split("").sort
	com_word = com_word.split("").sort
	com_word.each do |com_letter|
		if scr_word.find {|l| l == com_letter }
			scr_word.delete(com_letter)
		else
			return false
		end
	end
	return true
end


puts "Enter scramble word"
scramble_word = gets.chomp

puts "Enter compare word"
compare_word = gets.chomp

puts scramble(scramble_word, compare_word)
