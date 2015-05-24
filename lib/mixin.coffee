Function::extend = (from) ->
  merge @, from

Function::include = (from) ->
  merge @::, from::

merge = (to, from) ->
  for key, value of from
    unless to[key] || key == "__super__"
      to[key] = value
  
  to

module.exports = (klasses..., options={}) ->
  klasses.push(options) unless typeof options == "object"
  klasses.reduce (to, from, index, array) ->
    
    from.__super__ ||= to::
    real_to = array[index-1]::

    class
      @include from
      @extend  from

      @include to
      @extend  to

      constructor: ->
        makeArray = (a) ->
          if !a || a instanceof Array then a else [ a ]

        wrapFunctions = =>
          for name, fn of @
            stop   = name == "constructor"
            stop ||= typeof @[name] != "function"

            unless stop
              do (name, fn) =>
                @[name] = =>
                  if options.prepend && real_to[name]
                    args = real_to[name].apply @, arguments

                  args = fn.apply @, makeArray(args) || arguments

                  if options.append && real_to[name]
                    args = real_to[name].apply @, makeArray(args) || arguments

                  args

        wrapFunctions()

        if options.prepend
          args = from.__super__.constructor.apply @, arguments

        args = from.apply @, args || arguments

        if options.append
          from.__super__.constructor.apply @, args
