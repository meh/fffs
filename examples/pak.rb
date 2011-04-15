#! /usr/bin/env ruby
# http://wiki.xentax.com/index.php?title=Rising_Kingdoms

require 'thor'
require 'fffs'
require 'stringio'

class PakFile < FFFS::FileSystem
  def parse (content)
    stream = StringIO.new(content)

    # header
    if stream.read(16) != "HMMSYS PackFile\n"
      raise ArgumentError.new 'This is not a PAK file'
    end

    version         = stream.read(4).unpack('V').shift
    stream.read 12
    fileNumber      = stream.read(4).unpack('V').shift
		directoryLength = stream.read(4).unpack('V').shift

		current  = 0
		previous = nil

		1.upto(fileNumber) do
			nameLength      = stream.read(1).ord
			nameReuseLength = stream.read(1).ord

			path = String.new

			if nameReuseLength > 0 && previous
				path << previous[0, nameReuseLength]
			end

			path << stream.read(nameLength - nameReuseLength)

			path.gsub!('\\', '/')

			offset = stream.read(4).unpack('V').shift
			length = stream.read(4).unpack('V').shift

			into = self

			File.dirname(path).split('/').each {|dir|
				into = into[dir] || (into << FFFS::Directory.new(dir))
			}

			back = stream.tell; stream.seek(offset)
			into << FFFS::File.new(::File.basename(path), stream.read(length))
			stream.seek(back)

			previous = path
		end

		self
  end
end

class Application < Thor
  include Thor::Actions

  class_option :help, type: :boolean, desc: 'Show help usage'

  desc 'extract FILE [PATH]', 'Extract a PAK file'
  def extract (file, path='.')
    PakFile.parse(File.read(file)).save(path)
  end
end

Application.start(ARGV)
