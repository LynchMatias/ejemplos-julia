const jobs = Channel{Int}(32);

const results = Channel{Tuple}(32);

function work()
       for job_id in jobs
           exec_time = rand()
           sleep(exec_time)                # da tiempo, en el que simula trabajar
           put!(results, (job_id, exec_time))
       end
   end;

function make_jobs(n)
       for i in 1:n
           put!(jobs, i)
       end
   end;

n = 12;

@async make_jobs(n);

for i in 1:4 # arranca 4 tasks en paralelo
       @async work()
   end

@elapsed while n > 0
       job_id, exec_time = take!(results)
       println("$job_id finished in $(round(exec_time; digits=2)) seconds")
       global n = n - 1
   end
