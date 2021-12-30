# 15 Minutes
# 30th of December 2021 - Cello Version
# Passing some variables from :master to :choirS, I hope they are listening
# This version used for Minke, Fin and Humpback Whales videos
# Check the YouTube channel https://www.youtube.com/c/muuuh

ns_low = (scale :a2, :major_pentatonic, num_octaves: 2)
coff = 85

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :choir0 do
    n = sync 'master'
    length = n[0]
    note = n[1]
    play ns_low[note],
      attack: 1,
      release: length-1,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose
  end
  
  
  live_loop :choir1 do
    n = sync 'master'
    length = n[0]
    note = n[2]
    if length > 4 then
      sleep 2
      play ns_low[note],
        attack: 1,
        release: length -3,
        pan: (ring -0.5, 0, 0.5).choose,
        pan_slide: length - 2,
        cutoff: coff,
        mod_range: 0,
        amp: 0.5
    end
  end
  
  
  live_loop :choir2 do
    n = sync 'master'
    length = n[0]
    note = n[3]
    if length > 8 then
      sleep 4
      play ns_low[note],
        attack: 1,
        release: 5,
        pan: (ring -0.5, 0, 0.5).choose,
        pan_slide: 6,
        cutoff: coff,
        mod_range: 0,
        amp: 0.5
    end
  end
end

##| live_loop :beat do
##|   sample :bd_boom, amp: 0.4, release: 0.125  if (spread 1, 4).tick
##|   sleep 1
##| end



# by setting master at the end, no empty loop happens
live_loop :master do
  l =(ring 4, 4, 8, 4, 4, 8).tick
  n = rrand_i(0, 9)
  if n > 5 then
    i = n
    j = n - 5
    k = n - 3
  else
    i = n
    j = n + 5
    k = n + 6
  end
  cue 'master', l, i, j, k
  # sample :bd_tek, amp: 0.4, release: 0.125
  if l > 8 then
    sleep l + 1
  else
    sleep l
  end
end

