# 15 Minutes
# 4th of January 2022
# Dropping some instruments adding
# Next Step: Getting the chords and scales right for blues


ns_base = (ring :c2, :c2, :c2, :c2, :d2, :d2, :c2, :c2, :g2, :f2, :c2, :c2)
coff = 85

use_debug = false

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  
  
  live_loop :violin do
    n = sync 'master2violin'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = n[2]
    the_att = 0.05
    play note + 12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play note +24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play note+36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
  
  
end

live_loop :drums do
  sync :master
  sample :bd_tek, amp: 0.4, release: 0.125, pitch: 0
end


live_loop :master do
  l = 0.125
  n = ns_base.tick #rrand_i(0, 6)
  t = 4
  v = 1
  i = 0
  t.times do
    aug = (ring 0, 3, 7, 10).choose
    cue 'master2violin', n+12+aug, l, 1*v
    sleep l
  end
end
