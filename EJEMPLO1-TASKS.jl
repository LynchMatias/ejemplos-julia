function producer(c::Channel)
           put!(c, "Hola")
           for n=1:5
               put!(c, n)
           end
           put!(c, "Chau")
       end;

function consumer(c::Channel)
    for n=1:7
        print(take!(c))
        print("\n")
    end
end

c = Channel(producer)
consumer(c)
