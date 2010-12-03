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
  def initialize (text)
    @name = '/'

    self.parent     = self
    self.filesystem = self

    separator = Regexp.escape(text.match(/^(.+)$/)[1])
    text      = text.sub(/^.*$/, '').gsub(/\r/, '')
    text[-1]  = ''

    data = text.split(/\n\n#{separator} (.+?) #{separator}\n\n/)
    data.shift

    data.each_slice(2) {|(name, content)|
      path = ::File.dirname(name)

      if path == '.'
        parent = self 

        self << File.new(::File.basename(name), content)
      else
        into = nil

        path.split('/').each {|dir|
          into = self[dir] || (self << Directory.new(dir))
        }

        into << File.new(::File.basename(name), content)
      end
    }
  end

  def path (path=nil)
    '/'
  end
end

end
