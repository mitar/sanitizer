_.mixin
  startsWith: (string, start) ->
    string?.lastIndexOf(start, 0) is 0
