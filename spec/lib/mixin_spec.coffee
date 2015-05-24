mix = require("../../lib/mixin")

describe "Module", ->

  describe "three-level deep class inheritance with super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: -> @constructors.push("Mixin1")
        test:     (p) -> "hello #{p}"

      class Mixin2

        constructor: ->
          super
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"

      class Mixin3

        constructor: ->
          super
          @constructors.push("Mixin3")

        test:  ->
          super("world")
        test2: -> super("world 2")

      Test  = mix Mixin1, Mixin2, Mixin3
      @test = new Test()

    it "calls contructors", ->
      expect(@test.constructors).toEqual [ "Mixin1", "Mixin2", "Mixin3" ]

    it "calls super on first mixin", ->
      expect(@test.test()).toBe "hello world"

    it "calls super on second mixin", ->
      expect(@test.test2()).toBe "hello world 2"

    it "returns correct value without super", ->
      expect(@test.test3()).toBe "hello world 3"

  describe "three-level deep class inheritance with appended super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: ->
          @constructors.push("Mixin1")
        
        test: (p) ->
          "hello #{p}"

      class Mixin2

        constructor: ->
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"

      class Mixin3

        constructor: ->
          @constructors.push("Mixin3")

        test:  -> "world"
        test2: -> "world 2"

      Test  = mix Mixin1, Mixin2, Mixin3, append: true
      @test = new Test()

    it "calls contructors", ->
      expect(@test.constructors).toEqual [ "Mixin3", "Mixin2", "Mixin1" ]

    it "calls super on first mixin", ->
      expect(@test.test()).toBe "hello world"

    it "calls super on second mixin", ->
      expect(@test.test2()).toBe "hello world 2"

    it "returns correct value without super", ->
      expect(@test.test3()).toBe "hello world 3"

  describe "three-level deep class inheritance with prepended super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: ->
          @constructors.push("Mixin1")
        
        test:  -> "world"
        test2: -> "world 2"

      class Mixin2

        constructor: ->
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"

      class Mixin3

        constructor: ->
          @constructors.push("Mixin3")

        test: (p) -> "hello #{p}"

      Test  = mix Mixin1, Mixin2, Mixin3, prepend: true
      @test = new Test()

    it "calls contructors", ->
      expect(@test.constructors).toEqual [ "Mixin1", "Mixin2", "Mixin3" ]

    it "calls super on first mixin", ->
      expect(@test.test()).toBe "hello world"

    it "calls super on second mixin", ->
      expect(@test.test2()).toBe "hello world 2"

    it "returns correct value without super", ->
      expect(@test.test3()).toBe "hello world 3"
