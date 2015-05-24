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
  klasses.reduce (current, from, index, array) ->

    from.__super__ ||= current::

    makeArray = (a) ->
      if !a || a instanceof Array then a else [ a ]

    (
      (klass) =>
        for name, fn of klass
          do (name, fn) =>
            stop   = name == "constructor"
            stop ||= typeof klass[name] != "function"

            unless stop
              klass[name] = =>
                if options.prepend && current::[name]
                  args = current::[name].apply klass, arguments

                args = fn.apply klass, makeArray(args) || arguments

                if options.append && current::[name]
                  args = current::[name].apply klass, makeArray(args)

                args
    )(from::)

    class
      @include from
      @extend  from

      @include current
      @extend  current

      constructor: ->
        if options.prepend
          args = current::.constructor.apply @, arguments

        args = from.apply @, makeArray(args) || arguments

        if options.append
          args = current::.constructor.apply @, makeArray(args)

        return args
