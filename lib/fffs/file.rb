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

module FFFS

class File
  attr_accessor :filesystem, :parent

  attr_accessor :content
  attr_reader   :name

  def initialize (name, content='', parent=nil, filesystem=nil)
    @filesystem = filesystem
    @parent     = parent

    @name = name

    @content = content.clone
    @content.force_encoding 'ASCII-8BIT'
  end

  def name= (value)
    @parent.delete(@name)
    @name = value
    @parent << self
  end

  def path
    path    = []
    current = self

    begin
      path   << current.name
      current = current.parent
    end while current != current.parent

    "/#{path.reverse.join('/')}"
  end

  def inspect
    self.path
  end
end

end
