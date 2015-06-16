module.exports = (klasses..., options={}) ->
  unless typeof options == "object"
    klasses.push(options)
    options = {}

  root = class
  klasses.unshift root
  
  klasses.reduce (current, from, index, array) ->
    from.__super__ ||= current::

    wrapFunctions merge
      to: current::
      from: from::
      options

    class
      @include from
      @extend  from

      @include current
      @extend  current

      constructor: ->
        return wrapFunction merge
          bind:    @
          fn:      from
          fnSuper: current::.constructor
          args:    arguments
          options

makeArray = (a) ->
  if !a || a instanceof Array then a else [ a ]

merge = (to, from) ->
  for key, value of from
    unless to[key] || key == "__super__"
      to[key] = value
  
  to

wrapFunctions = (options={}) =>
  { to, from } = options

  for name, fn of from
    do (name, fn) ->
      stop   = name == "constructor"
      stop ||= typeof from[name] != "function"

      unless stop
        from[name] = ->
          wrapFunction merge
            bind:    @
            fn:      fn
            fnSuper: to[name]
            args:    arguments
            options

wrapFunction = (options={}) ->
  { fn, args, fnSuper, bind, prepend, append } = options

  if prepend && fnSuper
    result = fnSuper.apply bind, args

  result = fn.apply bind, makeArray(result) || args

  if append && fnSuper
    result = fnSuper.apply bind, makeArray(result)

  result

# Function extensions.
#

Function::extend = (from) ->
  merge @, from

Function::include = (from) ->
  merge @::, from::
