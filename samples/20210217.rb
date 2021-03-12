# It's Wednesday
# 17th of February 2021
# Random Continued

# https://sonic-pi.net/tutorial
# https://sonic-pi.mehackit.org/exercises/en/01-introduction/01-introduction.html

use_debug false
i = 0

ns_low = (scale :a2, :minor_pentatonic, num_octaves: 2)
ns = (scale :a3, :minor_pentatonic, num_octaves: 3)
series = (ring 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0, 0)
#series = (ring 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 3, 3, 3, 3, 3, 3)
#puts ns
tick_reset

with_fx :reverb, room: 1 do
  live_loop :random do
    
    tick
    sync :beat
    
    use_synth :pretty_bell
    use_synth :sine
    
    i = (ring 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10).look
    i = (ring 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10).reverse.look
    i = (ring 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10).mirror.look
    i = rand_i(11)
    i = 0
    #i = series.look
    puts i
    
    # o stands for ocatve
    o = rand_i(3)-3
    #o = -1
    
    # w stands for "from where?"
    w = (ring -1, -0.75, -0.5, 0, 0.5, 0.75, 1).mirror.look
    w = (ring -1, 0, 1).mirror.look
    w = 0
    
    # t stands for "timing"
    t = (ring 0.125, 0.125, 0.25, 0.125, 0.125, 0.25).look
    t = t-0.01
    
    play ns[i]+o*12, amp: 0.4, pan: w, release: t
    play ns[i+1]+o*12, amp: 0.2, pan: w, release: t if i % 2 == 0
    play ns[i+2]+o*12, amp: 0.1, pan: w, release: t if i % 3 == 0
    play ns[i+4]+o*12, amp: 0.1, pan: w, release: t if i % 4 == 0
    #play ns_low, amp: 0.5, release: t if i % 5 == 0
    
  end
  
end



#with_fx :wobble do
live_loop :wobbling do
  use_synth :hollow
  play ns_low.choose, amp: 0.6, attack: 4, release: 6
  sleep 10
end
#end

slow_down = 0

live_loop :beat do
  slow_down += 0.025
  #sample :drum_heavy_kick, slice: 0.125, amp: 1 if (spread 1, 4).tick
  sample :bd_tek, amp: 1, release: 0.125 if (spread 1, 4).tick
  sleep 0.25 +slow_down
end






