#--
# Copyleft meh. [http://meh.doesntexist.org | meh@paranoici.org]
#
# This file is part of fffs.
#
# fffs is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# fffs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with fffs. If not, see <http://www.gnu.org/licenses/>.
#++

require 'fffs/node'

module FFFS

class Directory < Hash
  include Node

  attr_accessor :filesystem, :parent

  attr_reader :name

  def initialize (name, files=[], parent=nil, filesystem=nil) 
    @filesystem = filesystem
    @parent     = parent

    @name = name

    files.each {|file|
      self[file.name] = file
    }
  end

  def filesystem= (value)
    self.each_value {|file|
      file.filesystem = value
    }

    @filesystem = value
  end

  def name= (value)
    @parent.delete(@name)
    @name = value
    @parent << self
  end

  def to_a
    self.map {|(name, file)| file}
  end

  def method_missing (id, *args, &block)
    self[id.to_s]
  end

  alias __set []=

  def []= (name, value)
    value.parent     = self
    value.filesystem = self.filesystem

    __set(name, value)
  end

  def push (file)
    if self[file.name].is_a?(Directory) && file.is_a?(Directory)
      self[file.name].merge(file)
    else
      self[file.name] = file
    end
  end

  alias << push

  def merge! (dir)
    dir.each_value {|file|
      self << file
    }
  end

  alias __path path

  def path
    "#{__path}/".sub(%r{/*/}, '/')
  end

  def save (path)
    require 'fileutils'

    FileUtils.mkpath(path)

    each_value {|f|
      f.save("#{path}/#{f.name}")
    }
  end

  def load (path)
    require 'find'

    Find.find(path) {|f|
      next unless ::File.file?(f) || ::File.symlink?(f)

      tmp  = ::File.dirname(f[path.length + 1, f.length]) rescue next
      into = self

      tmp.split('/').each {|dir|
        into = into[dir] || (into << Directory.new(dir))
      }

      if ::File.file?(f)
        into << File.new(::File.basename(f), ::File.read(f))
      elsif ::File.symlink?(f)
        into << Link.new(::File.basename(f), ::File.readlink(f))
      end
    }
  end

  def inspect
    output = "#{self.path}\n"

    self.each_value {|file|
      output << "#{file.inspect}\n"
    }

    output[-1] = ''; output
  end
end

end
