TerraTracker
===============

## Installation

Depenencies:

- Ruby 1.9.3
- SQLite3
- Bundler

To install:

    $ git clone git@github.com:TerraCoding/TerraTracker.git
    $ cd TerraTracker
    $ gem install bundler
    $ bundle install
    $ rake db:create:all
    $ rake db:migrate

For GoCardless integration, the `config/initializers/gocardless.rb.sample` needs renaming without .sample and API keys entered in.

Finally, you can start the server:

    $ rails s

And then you can access the app by visiting [http://localhost:3000/](http://localhost:3000/)

## License

[GNU General Public License, version 3.0](http://opensource.org/licenses/gpl-3.0.html)

## Contribute

I would be more than happy for people to contribute to this project. If you have anything to offer, then just send me a pull request.
