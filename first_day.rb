# Part One
frequency = 0
f = File.open('./first_day_input.txt', 'r')

while line=f.gets
  frequency += line.to_i
end

puts frequency

# Part Two
frequency = 0
observed_frequencies = []
found_duplicate = false
while !(found_duplicate)
  f = File.open('./first_day_input.txt', 'r')
  while line=f.gets
    frequency += line.to_i
    if observed_frequencies.include?(frequency)
      found_duplicate = true
      return frequency
    end
    observed_frequencies.push(frequency)
  end
end

puts frequency
