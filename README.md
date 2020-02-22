# Inline JS for Rails

[![Build Status](https://travis-ci.org/NialtoServices/ijs-rails.svg?branch=master)](https://travis-ci.org/NialtoServices/ijs-rails)

Inline JS can be used to include JavaScript files in your views in a minified format.

## Installation

You can install **Inline JS for Rails** using the following command:

  $ gem install ijs-rails

Or, by adding the following to your `Gemfile`:

```ruby
gem 'ijs-rails', '~> 0.1'
```

### Usage

Let's start with an example script *hello.js* which should be saved in the *app/javascript/inline* directory.

```js
//
// Example Script
//

alert('Hello, World!');
```

Next in a view, use the *render_ijs* method to render a *<script>* tag containing the minified script:

```ruby
<%= render_ijs 'hello' %>
```

## Development

After checking out the repo, run `bundle exec rake spec` to run the tests.

To install this gem onto your machine, run `bundle exec rake install`.
