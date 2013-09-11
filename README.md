# Alchemy: A Ruby Example

So the Ruby community loves Rails 4. Scala has Play 2. PHP has
Symfony 2 (or maybe Laravel 4, PHP is quite fragmented). These
web frameworks aim to make our lives, as developers, simpler.

Here are a few benefits that some frameworks provide:

 - Directory structure
 - HTTP routing
 - Dependency injection
 - Programming patterns
 - Testing
 - Consistent way of solving web application problems

All useful things. They make these decisions for you so you
don't have to. They also remove or reduce the boiler plate for
doing such things.

We have all worked on legacy, barnacled applications. We all
know how bad sans-framework can be. We developed frameworks to
remove the pain of repetition and disorganisation. I would
like to suggest that we can avoid repetition and
disorganisation without frameworks. We simply need a few solid
rules we can apply to web applications and across languages.
Essentially something like MVC without the framework and more
general advice too.

## About this example

This repository is a ruby web application that doesn't use
a framework. It's controllers are fully tested and every
other component testable.

![Build Status](https://travis-ci.org/DrPheltRight/alchemy.rb.png)
![Code Coverage](https://coveralls.io/repos/DrPheltRight/alchemy.rb/badge.png)

### Installing

From the command line you can install the dependencies to run
this project with bundler:

``` sh
bundle
```

### Running dev server

To run the reloadable dev server run:

``` sh
shotgun
```

### Running the tests

Again, just a simple command:

``` sh
rspec
```

### Technologies in use

So the only component used in the test suite independent of
the code written here by me is rspec itself. Running rspec is
quick because the code base is small. You'd also find it fast
in a larger environment too. This is because using dependency
injection there are no costly frameworks and libraries being
loaded into memory.

When running the dev web server, the application is served via
sinatra. Sinatra in this case is simply used as a routing
layer. Via the
`App::Interaction::Application::SinatraApplication` object
a request hash is created and passed into the controllers.
This is similar to the way hashes are passed directly into
the controllers in the test suite.

To render the web pages when running the dev web server we use
mustache.

In all I think you'll be pleasantly surprised if not confused.
It is my aim to reduce this confusion over time.

## Author

Luke Morton


