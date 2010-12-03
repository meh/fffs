#! /usr/bin/env ruby
require 'fffs'

fs = FFFS::FileSystem.parse(DATA.read)

puts fs.inspect
puts ''

puts "file's content:"
puts fs.file.content
puts ''

puts "dir/file's content:"
puts fs.dir.file.content

__END__
---

--- file ---

bla bla bla bla
blablabla
blablablablab lab lab la

--- dir/file ---

:3
