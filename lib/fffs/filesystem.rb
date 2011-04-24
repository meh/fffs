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

require 'fffs/directory'
require 'fffs/file'
require 'fffs/link'

module FFFS

class FileSystem < Directory
  def self.parse (text)
    fs = self.new

    fs.parse(text)

    return fs
  end

  def self.load (path)
    fs = self.new

    fs.load(path)

    return fs
  end

  def initialize
    @name = '/'

    self.parent     = self
    self.filesystem = self
  end

  def path (path=nil)
    '/'
  end

  def parse (text)
    separator = Regexp.escape(text.match(/^(.+)$/)[1])
    text      = text.sub(/^.*$/, '').gsub(/\r/, '')

    data = text.split(/\n\n#{separator} (.+?) #{separator}\n\n/)
    data.shift

    data.each_slice(2) {|(name, content)|
      if name.include?(' -> ')
        t, name, link = name.match(/^(.*?) -> (.*?)$/)
      end

      path = ::File.dirname(name)
      name = ::File.basename(name)

      if path == '.'
        parent = self 

        if link
          self << Link.new(name, link)
        else
          self << File.new(name, content)
        end
      else
        into = self

        path.split('/').each {|dir|
          into = into[dir] || (into << Directory.new(dir))
        }

        if link
          into << Link.new(name, link)
        else
          into << File.new(name, content)
        end
      end
    }
  end
end

end
