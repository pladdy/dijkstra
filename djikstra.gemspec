Gem::Specification.new do |s|
  s.name        = 'djikstra'
  s.version     = '0.0.1'
  s.date        = '2014-08-15'
  s.summary     = "Implement Djikstra algorithm to find shortest path from one 
                   node to another in a graph data structure.
                  "
  s.description = "This supports the creation and manipulation of DAG 
                   (directed acyclic graphs).
                  "
  s.authors     = ["Matt Pladna"]
  s.email       = 'pladdypants@gmail.com'
  s.files       = Dir['lib/**/*.rb', 'bin/**/*.rb']
  s.executables = ['djikstra']
  s.homepage    = 'http://www.nothingtoseehere.com'
  s.license     = 'OpenLikeABaus'
end
