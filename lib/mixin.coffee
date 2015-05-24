module.exports = ->

  merge = (to, from) ->
    for key, value of from
      unless to[key] || key == "__super__"
        to[key] = value
    
    to

  Function::extend = extend = (to, from) ->
    merge(@, from)

  Function::include = include = (to, from) ->
    merge(@::, from::)

  Function::mixin = mixin = (from, options={}) ->
    include @, from
    extend  @, from

    @.__super__ ||= from::
