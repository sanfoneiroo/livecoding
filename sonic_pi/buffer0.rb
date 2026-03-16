## BUFFER0 - MUSICAL DATA ##

set :steps, 16
set :step_time, 0.25

## GROOVE BANK ##

set :kick_bank, [
  (ring 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0), #0
  
  (ring 1,0,0,1, 0,0,0,0, 1,0,0,1, 0,0,0,0), #1
  
  (ring 1,0,0,1, 0,0,0,0, 1,0,0,1, 0,0,0,0), #2
  
  (ring 1,0,0,0, 1,1,0,0, 1,0,0,0, 1,1,0,0) #3
]

set :snare_bank, [
  (ring 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0), #0
  
  (ring 0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,0), #1
  
  (ring 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0), #2
  
  (ring 0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0) #3
]

set :hihat_bank, [
  (ring 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0), #0
  
  (ring 1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0), #1
  
  (ring 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1), #2
  
  (ring 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1) #3
]


set :melody_bank, [
  (ring
   nil,nil,nil,nil,nil,nil,nil,nil,
   nil,nil,nil,nil,nil,nil,nil,nil
   ), #0
  
  (ring
   :g4,nil,:bb4,nil,:d5,nil,:f5,nil,
   :d5,:d5,:bb4,:bb4,:g4,:g4,:f5,nil
   ), #1
  
  (ring
   :g4,nil,:bb4,nil,:c5,nil,:e5,nil,
   :c5,:c5,:bb4,:bb4,:g4,:g4,:e5,nil
   ), #2
  
  (ring
   :a4,nil,:c5,nil,:d5,nil,:gb5,nil,
   :d5,:d5,:c5,:c5,:a4,:a4,:d5,nil
   ) #3
  
]

set :bass_bank, [
  
  (ring
   nil,nil,nil,nil,nil,nil,nil,nil,
   nil,nil,nil,nil,nil,nil,nil,nil
   ), #0
  
  (ring
   :g3,nil,nil,:bb3,nil,nil,:f3,nil,
   :g3,nil,nil,:g4,:bb3,nil,:d4,nil
   ), #1
  
  (ring
   :g4,nil,nil,:e3,nil,nil,:bb3,nil,
   :c3,nil,nil,:c4,:e3,nil,:g3,nil
   ), #2
  
  (ring
   :d3,nil,nil,:a4,nil,nil,:a3,nil,
   :d3,nil,nil,:a4,:a3,nil,:d3,nil
   ) #3
  
]
