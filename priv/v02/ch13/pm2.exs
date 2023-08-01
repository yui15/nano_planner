x = [:a, :b, :c]
[y , :b | z] = x
IO.inspect(y)
IO.inspect(z)
