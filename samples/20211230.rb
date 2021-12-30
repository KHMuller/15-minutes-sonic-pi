# 15 Minutes
# 30th of December 2021
# Waves
# Passing some variables from :master to :choirS, I hope they are listening

ns_low = (scale :a2, :major_pentatonic, num_octaves: 3)


use_synth :tech_saws
with_fx :reverb, mix: 0.7 do
  live_loop :choir0 do
    n = sync 'master'
    length = n[0]
    note = n[1]
    play ns_low[note],
      attack: length/2,
      release: length/2,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: length
  end
  
  
  live_loop :choir1 do
    n = sync 'master'
    length = n[0]
    note = n[2]
    if length > 4 then
      sleep 2
      play ns_low[note],
        attack: (length-2)/2,
        release: (length-2)/2,
        pan: (ring -0.5, 0, 0.5).choose,
        pan_slide: length - 2
    end
  end
  
  
  live_loop :choir2 do
    n = sync 'master'
    length = n[0]
    note = n[3]
    if length > 8 then
      sleep 4
      play ns_low[note],
        attack: (length-4)/2,
        release: (length-4)/2,
        pan: (ring -0.5, 0, 0.5).choose,
        pan_slide: length - 4
    end
  end
end


# by setting master at the end, no empty loop happens
live_loop :master do
  l =(ring 2, 2, 2, 6, 6, 2, 2, 2, 6, 6, 2, 2, 2, 12).tick
  n = rrand_i(0, 15)
  if n > 6 then
    i = n
    j = n - 7
    k = n - 5
  else
    i = n
    j = n + 7
    k = n + 9
  end
  cue 'master', l, i, j, k
  # sample :bd_tek, amp: 0.4, release: 0.125
  if l > 8 then
    sleep l + 1
  else
    sleep l
  end
end

