module.exports = ->

  Function::extend = extend = (to, from) ->
    [ to, from ] = [ @, to ] unless from

    merge(to, from)

  Function::include = include = (to, from) ->
    [ to, from ] = [ @, to ] unless from

    merge(to::, from::)

  Function::merge = merge = (to, from) ->
    [ to, from ] = [ @, to ] unless from

    for key, value of from
      to[key] = value unless to[key] || key == "__super__"
    
    to

  Function::mixin = mixin = (to, from) ->
    [ to, from ] = [ @, to ] unless from

    include(to, from)
    extend(to, from)

    to.__super__ ||= from::
