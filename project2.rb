module Enumerable

	def my_each
		if block_given?
			for i in 0...self.length
				yield(self[i])
				i+=1
			end
			self
		else
			self.to_enum
		end
	end

	def my_each_with_index
		if block_given?
			for i in 0...self.length
				yield(self[i], i)
				i += 1
			end
			self
		else
			self.to_enum
		end
	end

	def my_select
		if block_given?
			output = []
			self.my_each do |x|
				if yield(x)
					output.push(x)
				end
			end
			output
		else
			self.to_enum
		end
	end

	def my_all?
		if block_given?
			self.my_each do |x|
				if yield(x) == false
					return false
				end
			end
			true
		else
			if (self.my_any? {|x| x == nil || x == false}) == true
				return false
			else
				self.my_all? {|x| x}
			end
		end
	end

	def my_any?
		if block_given?
			self.my_each do |x|
				if yield(x)
					return true
				end
			end
			false
		else
			if (self.my_all? {|x| x == false || x == nil})
				return false
			else
				return true
			end
		end
	end

	def my_none?
		if block_given?
			self.my_each do |x|
				if yield(x) == true
					return false
				end
			end
			true
		else
			false
		end
	end

	def my_count(param = nil)
		count = 0
		self.my_each do |x|
			if block_given?
				if param
					if param == x
						count += 1
					end
				else
					if yield(x) == true
						count += 1
					end
				end
			elsif param == nil
				count += 1
			else
				if param == x
					count += 1
				end
			end
		end
		count
	end

	def my_map(&block)
		array = []
		self.my_each do |x|
			array << yield(x)
		end
		array
	end

	def my_inject(total = nil)
		if total == nil
			total = self[0]
			self[1...self.length].my_each do |x|
				total = yield(total, x)
			end
		else
			self.my_each do |x|
				total = yield(total, x)
			end
		end
		total
	end

end





def multiply_els(array)
	array.my_inject {|total, x| total * x}
end







array = [1, 2, 3, 4, 5]
array.each do |x|
	puts x + 1
end

array.my_each do |x|
	puts x + 1
end

array.each_with_index do |x, i|
	puts "#{x+1}: #{i}"
end

array.my_each_with_index do |x, i|
	puts "#{x+1}: #{i}"
end

puts array.select {|x| x > 2}

puts array.my_select {|x| x > 2}

puts array.all? {|x| x > 1}
puts array.all? {|x| x > 0}

puts array.my_all? {|x| x > 1}
puts array.my_all? {|x| x > 0}

puts array.any? {|x| x == 45}
puts array.any? {|x| x == 2}

puts array.my_any? {|x| x == 45}
puts array.my_any? {|x| x == 2}

puts array.none? {|x| x == 45}
puts array.none? {|x| x == 2}

puts array.my_none? {|x| x == 45}
puts array.my_none? {|x| x == 2}

puts array.count {|x| x > 3}
puts array.count {|x| x >= 5}

puts array.my_count {|x| x > 3}
puts array.my_count {|x| x >= 5}

puts array.map {|x| x * 5}

puts array.my_map {|x| x * 5}

puts array.inject {|total, x| total + x}
puts array.inject(2) {|total, x| total + x}

puts array.my_inject {|total, x| total + x}
puts array.my_inject(2) {|total, x| total + x}

puts multiply_els(array)

new_proc = Proc.new {|x| x * 3}

puts array.my_map(&new_proc)
puts array.my_map {|x| x * 4}