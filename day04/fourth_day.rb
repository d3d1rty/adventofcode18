require 'time'

f = File.open('fourth_day_input.txt', 'r')

unparsed_lines = []

while line=f.gets
  unparsed_lines.push(line.chomp)
end

unparsed_lines.sort!

# parse each line into hash; collect guard ids for later use
parsed_lines = []
guard_ids = []
unparsed_lines.each do |line|
  guard_hash = {}
  guard_hash[:datetime] = Time.parse(line.slice(0,18))
  guard_hash[:action] = line.slice(19..-1)
  guard_hash[:guard_id] = guard_hash[:action].scan(/\d+/).first
  guard_ids.push(guard_hash[:guard_id]) unless guard_hash[:guard_id].nil?
  parsed_lines.push(guard_hash)
end

# Set guard ids for each line
guard_id = parsed_lines[0][:guard_id]
parsed_lines.each do |hash|
  if hash[:guard_id].nil?
    hash[:guard_id] = guard_id
  else
    guard_id = hash[:guard_id]
  end
end

# initialize array of guard sleep minutes
sleep_times = []
guard_ids.uniq.each do |id|
  sleep_times.push({ guard_id: id, total_sleep_time: 0, minutes_asleep: [], minute_indices: [] })
end

# Populate sleep information by guard
parsed_lines.each_with_index do |line, index|
  if line[:action] == 'falls asleep'
    sleep_times.each do |hash|
      if hash[:guard_id] == line[:guard_id]
        snooze_duration = (parsed_lines[index+1][:datetime] - line[:datetime])/60
        hash[:minutes_asleep].push(snooze_duration)
        hash[:total_sleep_time] = hash[:minutes_asleep].sum
        snooze_duration.to_i.times do |count|
          hash[:minute_indices].push(line[:datetime].min + count)
        end
        break
      end
    end
  end
end

# Determine which guard sleeps the most
sleepiest_guard = ''
biggest_sleep_time = 0
sleep_time_index = 0
sleep_times.each_with_index do |hash, index|
  if hash[:total_sleep_time] > biggest_sleep_time
    biggest_sleep_time = hash[:total_sleep_time]
    sleepiest_guard = hash[:guard_id]
    sleep_time_index = index
  end
end

minutes = sleep_times[sleep_time_index][:minute_indices]

minute = minutes.max_by { |i| minutes.count(i) }
puts "The sleepiest guard is #{sleepiest_guard} and he slept the most at #{minute} minute."
puts "The solution for Part One is #{sleepiest_guard.to_i * minute}."

min_most_slept_at = 0
times_most_slept_at_min = 0
solution = { guard_id: '', min_most_slept_at: 0, times_most_slept_at_min: 0 }
sleep_times.each do |hash|
  mins = hash[:minute_indices]
  min_most_slept_at = mins.max_by { |i| mins.count(i) }
  times_most_slept_at_min = mins.count(min_most_slept_at)
  if times_most_slept_at_min > solution[:times_most_slept_at_min]
    solution[:guard_id] = hash[:guard_id]
    solution[:min_most_slept_at] = min_most_slept_at
    solution[:times_most_slept_at_min] = times_most_slept_at_min
  end
end

puts "The solution for Part Two is #{solution[:guard_id].to_i * solution[:min_most_slept_at]}."
