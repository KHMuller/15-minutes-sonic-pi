# 15 Minutes
# 25th of January 2022
# A new start - continued ...

use_debug false

define :blade do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.2
  end
end

define :violin do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 1
  end
end

live_loop :drums do
  use_bpm 60
  #sample :bd_tek, amp: 0.5, release: 0.125, pitch: 0
  sleep 1
end

curr_bpm = 30
curr_length = 4
ns = (scale :c3, :minor_pentatonic, num_octaves = 2)

live_loop :master0 do
  use_bpm curr_bpm
  
  base = ns.mirror.tick(:goup)
  blade(base, curr_length)
  sleep curr_length
  blade(base+7, curr_length)
  sleep curr_length
end
live_loop :master1 do
  use_bpm curr_bpm
  
  goback = ns.reverse.mirror.tick(:godown)
  blade(goback, curr_length)
  sleep curr_length
  blade(goback-3, curr_length)
  sleep curr_length
end
live_loop :master3 do
  use_bpm curr_bpm
  
  anywhere = ns.mirror.shuffle.tick(:anywhere)
  blade(anywhere, curr_length)
  sleep curr_length
  blade(anywhere+[-3, 7].choose, curr_length)
  sleep curr_length
end

use_scale = :minor_pentatonic

live_loop :master do
  use_bpm 1200 #speedup.tick(:speeding)
  
  a = (ring 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1).mirror
  l = (ring 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1).tick(:basemotif)
  l = l*2
  n_f = (scale :c1, use_scale, num_octaves: 4).choose
  n_n = (scale :c2, use_scale, num_octaves: 2).choose
  n_1 = (scale :c1, use_scale, num_octaves: 1).choose
  n_2 = (scale :c2, use_scale, num_octaves: 1).choose
  n_3 = (scale :c3, use_scale, num_octaves: 1).choose
  n_4 = (scale :c4, use_scale, num_octaves: 1).choose
  violin(n_f, l, 0.5+a.choose, 0.25) if (spread 8, 8).tick(:organobeat1)
  sleep l
  
end
