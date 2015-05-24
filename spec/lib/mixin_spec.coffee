require("../../lib/mixin")()

describe "Module", ->

  describe "three-level deep class inheritance with super", ->

    beforeAll ->
    
      Mixin1 = class
        constructors: []

        constructor: ->
          @constructors.push("Mixin1")
        
        test: (p) -> "hello #{p}"

      Mixin2 = class
        @mixin Mixin1

        constructor: ->
          super
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"

      @Mixin3 = class
        @mixin Mixin2

        constructor: ->
          super
          @constructors.push("Mixin3")

        test: ->  super("world")
        test2: -> super("world 2")

      @test = new @Mixin3()

    it "calls contructors", ->
      expect(@test.constructors).toEqual [ "Mixin1", "Mixin2", "Mixin3" ]

    it "calls super on first mixin", ->
      expect(@test.test()).toBe "hello world"

    it "calls super on second mixin", ->
      expect(@test.test2()).toBe "hello world 2"

    it "returns correct value without super", ->
      expect(@test.test3()).toBe "hello world 3"
