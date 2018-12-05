def compare_char(a, b)
  (a.match?(/[A-Z]/) && b.match?(/[a-z]/)) || (a.match?(/[a-z]/) && b.match?(/[A-Z]/))
end

def combust_chain(molecule_arr)
  i = 0
  while (true)
    break if i == molecule_arr.length
    if molecule_arr[i].casecmp?(molecule_arr[i+1])
      if compare_char(molecule_arr[i], molecule_arr[i+1])
        molecule_arr[i] = nil
        molecule_arr[i+1] = nil
        molecule_arr.compact!
        next if i == 0
        i -= 1
      else
        i += 1
      end
    else
      i += 1
      next
    end
  end
  molecule_arr
end

f = File.open('./fifth_day_input.txt', 'r')

polymer_chain = ''
while line=f.gets
  polymer_chain = line
end

molecule_arr = combust_chain(polymer_chain.split(//))

puts "The solution to Part One is: #{molecule_arr.length-1}"

results = []
'ABCDEFGHJKLMNOPQRSTUVWXYZ'.each_char do |char|
  temp_chain = polymer_chain.split(//)
  temp_chain.delete(char.upcase)
  temp_chain.delete(char.downcase)
  result = combust_chain(temp_chain)
  results.push(result.length-1)
end

puts "The solution to Part Two is: #{results.sort.first}"
