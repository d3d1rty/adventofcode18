#! /bin/bash ruby
f = File.open('day02/second_day_input.txt', 'r')
box_ids_for_dubs = 0
box_ids_for_trips = 0

# Part One
while line=f.gets
  tally = {}
  line.each_char do |c|
    if tally[c]
      tally[c] += 1
    else
      tally[c] = 1
    end
  end

  found_dubs = false
  found_trips = false
  tally.each do |key, value|
    found_dubs = true if value == 2
    found_trips = true if value == 3
  end
  box_ids_for_dubs += 1 if found_dubs == true
  box_ids_for_trips += 1 if found_trips == true
  found_dubs = false
  found_trips = false
end

checksum = box_ids_for_dubs * box_ids_for_trips
puts checksum

# Part Two
f = File.open('day02/second_day_input.txt', 'r')
line_str_maps = []
target_boxes = []
while line=f.gets
  string_arr = []
  line.chomp.each_char do |c|
    string_arr.push(c)
  end
  line_str_maps.push(string_arr)
end

line_str_maps.each_with_index do |str_arr, index|
  str_arr.each_with_index do |char, str_index|
    line_str_maps.each_with_index do |compare_arr, i|
      num_diff = 0
      diff_index = 0
      next if i == index
      compare_arr.each_with_index do |c, c_str_index|
        num_diff += 1 unless str_arr[c_str_index] == compare_arr[c_str_index]
        break if num_diff > 1
        diff_index = c_str_index if str_arr[c_str_index] == compare_arr[c_str_index]
      end
      if num_diff == 1 && str_index == diff_index
          target_boxes.push(str_arr.join.to_s)
          target_boxes.push(compare_arr.join.to_s)
      end
    end
  end
end

boxes = target_boxes.uniq

chars = boxes.first.length
diff_index = 0

chars.times do |i|
  next if boxes.first[i] == boxes.last[i]
  diff_index = i
end

puts boxes.first.slice(0..diff_index-1) + boxes.first.slice(diff_index+1..-1)
