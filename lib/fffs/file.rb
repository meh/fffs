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

class File
  include Node

  attr_accessor :filesystem, :parent

  attr_accessor :content
  attr_reader   :name, :mode

  def initialize (name, content='', parent=nil, filesystem=nil)
    @filesystem = filesystem
    @parent     = parent

    @name = name
    @mode = 0644

    @content = content.clone
    @content.force_encoding 'ASCII-8BIT'
  end

  def name= (value)
    @parent.delete(@name)
    @name = value
    @parent << self
  end

  def chmod (mode)
    @mode = mode
  end

  def save (file, mode=nil)
    result = true

    if file.is_a?(String)
      ::File.open(file, 'wb') {|f|
        result = f.write content

        begin
          f.chmod(mode || @mode)
        rescue Exception => e
        end
      }
    else
      result = file.write content
      file.flush

      begin
        file.chmod(mode || @mode)
      rescue Exception => e
      end
    end

    result
  end

  def execute (*args)
    require 'tempfile'

    tmp = Tempfile.new('fffs')
    tmp.chmod 0700

    save(tmp)

    tmp.close

    Kernel.system(tmp.path, *args)
  ensure
    tmp.unlink
  end

  def to_s
    @content
  end

  def inspect
    self.path
  end
end

end
