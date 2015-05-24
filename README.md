# coffee-mixin

Powerful mixins and monkeypatches for coffeescript.

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

## Wrap Super (Monkeypatch)

Automatically call super before or after each function is executed.

### Prepend Example

Transparently monkeypatch, even on constructors!

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

### Append Example

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
