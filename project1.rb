def bubble_sort(array)
	for iteration in 1..array.length
		for index in 0...array.length
			if array[index] == array.last
				index = 0
			end
			if array[index] > array[index + 1]
				x, y = array[index], array[index + 1]
				array[index] = y
				array[index + 1] = x
			end
			index += 1
		end
		iteration += 1
	end
	puts array
end

bubble_sort([7, 84, 32, 97, 1])