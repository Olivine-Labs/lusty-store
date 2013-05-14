local store = function(method)
  return function(collection, query, data)
    context.lusty:publish(
    { 'store', method, collection },
    { method=method, query = query, data = data, collection=collection }
    )
  end
end

context.store = setmetatable({}, {
  __index = function(self, key)
    local val = rawget(self, key)

    if not val then
      val = store(key)
      self[key] = val
    end
    return val
  end
})
