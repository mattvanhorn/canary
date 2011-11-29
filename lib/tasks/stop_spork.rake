desc 'Stop spork'
task :stop_spork do
  cuke  = %(ps xa | grep [s]pork | grep 8990 | awk '{print $1}' | xargs kill)
  rspec = %(ps xa | grep [s]pork | grep 8989 | awk '{print $1}' | xargs kill)
  puts %x{#{cuke}}
  puts %x{#{rspec}}  
end
task "db:test:prepare" => :stop_spork