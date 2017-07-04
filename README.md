# DiyProf

DiyProf is a very simple call graph visualiser for Ruby.

## Installation

DiyProf uses `dot` format to record the call graph.


If you want DiyProf to produce PDF files, please install [GraphViz](http://www.graphviz.org) beforehand. E.g. on macOS:

```bash
brew install graphviz
```


Add this line to your application's Gemfile:

```ruby
gem 'diy_prof'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diy_prof

## Usage

```ruby
def method1
  method2
end

def method2
  puts "in method2"
end

DiyProf.start_profiling
method1
pdf = DiyProf.stop_and_output(format: :pdf)
system("open #{pdf}")
```

This opens a PDF similar to this:

![Example PDF](examples/example.png)


See [demo.rb](examples/demo.rb) for full example.


### Without GraphViz

If you do not wan't to or can't install GraphViz, you can just get the `dot` format and use it as you see fit:
 
```ruby
DiyProf.start_profiling
method1
dot_file = DiyProf.stop_and_output  # default format is :dot
```

### Ruby on Rails

With Ruby on Rails (or any bigger project for that matter) it might not be possible to automatically open the PDF as in the example. In such case the `stop_and_output` takes a directory name that the file will be placed in and the intended usage is:

```ruby
DiyProf.start_profiling

# do some stuff here

# Place PDF to Rails' tmp/ directory
DiyProf.stop_and_output(dir: 'tmp', format: :pdf)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/diy_prof/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
