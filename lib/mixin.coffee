module.exports = (klasses..., options={}) ->
  unless typeof options == "object"
    klasses.push(options)
  
  klasses.reduce (current, from, index, array) ->
    from.__super__ ||= current::

    wrapFunctions current::, from::, options

    class
      @include from
      @extend  from

      @include current
      @extend  current

      constructor: ->
        return wrapFunction(
          from, arguments, current::.constructor, @, options
        )

makeArray = (a) ->
  if !a || a instanceof Array then a else [ a ]

merge = (to, from) ->
  for key, value of from
    unless to[key] || key == "__super__"
      to[key] = value
  
  to

wrapFunctions = (to, from, options={}) =>
  for name, fn of from
    do (name, fn) ->
      stop   = name == "constructor"
      stop ||= typeof from[name] != "function"

      unless stop
        from[name] = ->
          wrapFunction fn, arguments, to[name], from, options

wrapFunction = (fn, fnArgs, fnSuper, bind, options={}) ->
  if options.prepend && fnSuper
    args = fnSuper.apply bind, fnArgs

  args = fn.apply bind, makeArray(args) || fnArgs

  if options.append && fnSuper
    args = fnSuper.apply bind, makeArray(args)

  args

# Function extensions.
#

Function::extend = (from) ->
  merge @, from

Function::include = (from) ->
  merge @::, from::
