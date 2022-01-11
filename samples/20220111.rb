# 15 Minutes
# 11th of January 2022
# Need calm sound track for video Selected Photos 2021 [3:16]
# Listen to it on YouTube https://youtu.be/3ghgvl1HVVQ


ns_low = (scale :a2, :minor, num_octaves: 3)
coff = 85

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  
  
  live_loop :cello do
    n = sync 'master2cello'
    note = n[0]
    length = n[1]
    the_pan = (ring 0.5).choose
    the_amp = n[2]
    the_att = 0.5
    coff = note + 24 + 1
    play note,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 13,
      mod_range: 0,
      amp: the_amp
    play note + 12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 25,
      mod_range: 0,
      amp: the_amp/2
    play note+24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 37,
      mod_range: 0,
      amp: the_amp/4
  end
end



live_loop :master do
  
  ns_low = (scale :a2, :minor, num_octaves: 1).mirror
  l = (ring 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 4, 6, 2).tick(:basemotif)
  n = ns_low.tick(:basescale)
  tick(:basescale)
  n = ns_low.choose
  cue 'master2cello', n, l, 1
  if l == 2 then
    cue 'master2cello', n+5, l, 1
  end
  if l == 4 then
    cue 'master2cello', n+3, l, 1
  end
  if l == 6 then
    cue 'master2cello', n+7, l, 1
  end
  
  sleep l
end
