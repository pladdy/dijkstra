# Dijkstra
Implementation of dijkstra's algorithm in ruby

## Algorithm
https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm

## Installation
```
git clone git@github.com:pladdy/dijkstra.git
cd dijkstra
gem build dijkstra.gemspec
gem install --local dijkstra-0.0.1.gem
```
## Usage
`dijkstra [path_to_graph] [point_a] [point_b]`

## Examples
```
$ dijkstra test/graph1.txt A G
Shortest path is A,B,E,G with cost 6
$ dijkstra test/graph2.txt SY AD
Shortest path is SY,CB,ME,AD with cost 18
```
