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

class Link
  attr_accessor :filesystem, :parent
  
  attr_accessor :to

  def initialize (file, parent=nil, filesystem=nil)
    @parent = parent
    @to     = file
  end

  def content
    handle = self.filesystem

    @to.split('/').reject {|s| s.empty?}.each {|path|
      handle = handle[path]

      break if !handle
    }

    if handle
      handle.content rescue ''
    end
  end
end

end
