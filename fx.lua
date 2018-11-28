local tb = {page="12",debug=true,1,2,3,45,5}

-- 只是列出了当前的索引的内容
for k,v in ipairs(tb) do
  print(k,v)
end

--便利当前表内的所有内容，按照索引和key=>value的方式展示
for k,v in pairs(tb) do
    print(k,v)
end 


local ta = {fk='fj'}
ta.__index = function(slef,v) -- 当前查找的对象 self = tb v = fk 查询的值
    print(slef.page,v)
    return '12' -- 不管调用的是什么内容返回的都是‘12’
  end
tb = setmetatable(tb,ta)

print('ad=>',tb.fk) --12
