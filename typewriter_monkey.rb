#!/usr/bin/env ruby

def solve(keys, length, target)
  return 0 if target.split('').any?{ |t| !keys.include?(t) }


  # good_keys = keys.select{ |k| target.include? k }
  # bad_keys = keys.select{ |k| !target.include? k }
  # puts "good #{good_keys}"
  # puts "bad  #{bad_keys}"
  permutations = keys.repeated_permutation(length).map{|a| a.join('')}
  # puts "perm : #{permutations}"
  counts = permutations.map{|w| count(w, target)}
  sum = 0
  max = 0
  count = 0
  counts.each do |c|
    sum += c
    max = c if c > max
    count += 1
  end
  average = sum.to_f / count
  (max - average).round(6)
end

def count(word, target)
  count = 0
  index = nil
  while not (index = word.index(target)).nil? do
    count += 1
    word = word[index+1-word.length, word.length-index-1]
  end
  count
end

def test_count(word, target, expect)
  actual = count(word.dup, target)
  raise "count fails #{word}>#{target}, expect=#{expect} actual=#{actual}" if actual != expect
end

test_count "ABAC", "DEF", 0
test_count "ABAC", "BA", 1
test_count "ABABA", "BA", 2
test_count "AAAAA", "AA", 4
test_count "ABABAB", "ABAB", 2

case_count = gets.chomp.to_i
case_count.times { |cc|
  buffer = gets.chomp.split(' ')
  k = buffer[0].to_i
  l = buffer[1].to_i
  s = buffer[2].to_i
  keys = gets.chomp.split('')
  target = gets.chomp

  # puts "#{keys}"
  # puts "#{s}"
  # puts "#{target}"
  ans = solve keys, s, target
  puts "Case ##{cc+1}: #{ans}"
  # puts "new coins - #{ans}"
}
