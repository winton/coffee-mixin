# coffee-mixin

    mix = require("coffee-mixin")

    class A
      constructor: -> console.log "hello"
      world: ->       console.log "world"

    class B

      constructor: -> super()
      world:       -> super()

    C = mix A, B

    new C().world()
      #
      # hello
      # world

## Options

We can also automatically wrap all functions to call super before or
after the function is executed.

    @mixin [Class],
      append:  false, # append  all functions with super
      prepend: false, # prepend all functions with super

## Append Example

    mix = require("coffee-mixin")

    class A
      constructor: (str) -> console.log "#{str}lo"
      world:       (str) -> console.log "#{str}ld"

    class B

      # CoffeeScript does not `return` by default in constructors.
      #
      constructor: -> return "hel"
      world:       -> "wor"

    C = mix A, B, append: true

    new C().world()
      #
      # hello
      # world

## Prepend Example

    mix = require("coffee-mixin")

    class A

      # CoffeeScript does not `return` by default in constructors.
      #
      constructor: -> return "hel"
      world:       -> "wor"

    class B
      constructor: (str) -> console.log "#{str}lo"
      world:       (str) -> console.log "#{str}ld"

    C = mix A, B, prepend: true

    new C().world()
      #
      # hello
      # world
