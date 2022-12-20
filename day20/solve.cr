def solve(input, times)
  nexts = Array.new(input.size) { |i| (i + 1) % input.size }

  times.times do
    input.each_with_index do |value, index|
      next if value == 0

      left, right = index, nexts[index]
      nexts[nexts.index!(&.== index)] = right

      (value % (input.size - 1)).times { left, right = right, nexts[right] }

      nexts[left] = index
      nexts[index] = right
    end
  end

  start = input.index!(&.== 0)

  {1000, 2000, 3000}.sum do |idx|
    right = start
    (idx % input.size).times { right = nexts[right] }
    input[right]
  end
end

input = {{ read_file("day20/input.txt").strip }}.lines.map(&.to_i64)
# input = {{ read_file("day20/test0.txt").strip }}.lines.map(&.to_i64)

puts solve(input, 1)
puts solve(input.map(&.* 811589153), 10)
