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
