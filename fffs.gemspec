Gem::Specification.new {|s|
    s.name         = 'fffs'
    s.version      = '0.0.2'
    s.author       = 'meh.'
    s.email        = 'meh@paranoici.org'
    s.homepage     = 'http://github.com/meh/fffs'
    s.platform     = Gem::Platform::RUBY
    s.description  = 'A virtual filesystem for embedded data.'
    s.summary      = 'A virtual filesystem.'
    s.files        = Dir.glob('lib/**/*.rb')
    s.require_path = 'lib'
    s.has_rdoc     = true
}
