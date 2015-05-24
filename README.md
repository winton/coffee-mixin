# coffee-mixin

    require("coffee-mixin")()

    class A
      constructor: -> console.log "hello"
      world: ->       console.log "world"

    class B
      @mixin A

      constructor: -> super()
      world:       -> super()

    new B().world()

    # Outputs:
    #   hello
    #   world

## Options

Available options with default values:

    @mixin [Class],
      appendSuper:  false, # monkeypatch all functions with super (append)
      prependSuper: false, # monkeypatch all functions with super (prepend)
      changeSuper:  true   # modify existing super
