mix = require("../../lib/mixin")

describe "Module", ->

  describe "three-level deep class inheritance with super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: -> @constructors.push("Mixin1")
        test:    (p) -> "hello #{p}"
        test4:   (p) -> "a #{p}"

      class Mixin2

        constructor: ->
          super
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"
        test4: (p) -> super "b #{p}"

      class Mixin3

        constructor: ->
          super
          @constructors.push("Mixin3")

        test:  -> super("world")
        test2: -> super("world 2")
        test4: -> super("c")

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

    it "returns correct value on all mixins", ->
      expect(@test.test4()).toBe "a b c"

  describe "three-level deep class inheritance with appended super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: ->
          @constructors.push("Mixin1")
        
        test: (p) ->
          "hello #{p}"
        test4: (p) -> "a #{p}"

      class Mixin2

        constructor: ->
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"
        test4: (p) -> "b #{p}"

      class Mixin3

        constructor: ->
          @constructors.push("Mixin3")

        test:  -> "world"
        test2: -> "world 2"
        test4: -> "c"

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

    it "returns correct value on all mixins", ->
      expect(@test.test4()).toBe "a b c"

  describe "three-level deep class inheritance with prepended super", ->

    beforeAll ->
    
      class Mixin1
        constructors: []

        constructor: ->
          @constructors.push("Mixin1")
        
        test:  -> "world"
        test2: -> "world 2"
        test4: -> "c"

      class Mixin2

        constructor: ->
          @constructors.push("Mixin2")

        test2: (p) -> "hello #{p}"
        test3:     -> "hello world 3"
        test4: (p) -> "b #{p}"

      class Mixin3

        constructor: ->
          @constructors.push("Mixin3")

        test:  (p) -> "hello #{p}"
        test4: (p) -> "a #{p}"

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

    it "returns correct value on all mixins", ->
      expect(@test.test4()).toBe "a b c"

  describe "constructor returns appended super values", ->

    beforeAll ->
    
      class Mixin1
        constructor: (ab) ->
          @result = "#{ab} c"
        
      class Mixin2

        constructor: (a) ->
          return "#{a} b"

      class Mixin3

        constructor: ->
          return "a"

      Test  = mix Mixin1, Mixin2, Mixin3, append: true
      @test = new Test()

    it "calls contructors", ->
      expect(@test.result).toBe "a b c"

  describe "constructor returns prepended super values", ->

    beforeAll ->
    
      class Mixin1
        constructor: -> return "a"
        
      class Mixin2

        constructor: (a) -> return "#{a} b"

      class Mixin3

        constructor: (ab) -> @result = "#{ab} c"

      Test  = mix Mixin1, Mixin2, Mixin3, prepend: true
      @test = new Test()

    it "calls contructors", ->
      expect(@test.result).toBe "a b c"
