# 15 Minutes
# 5th of January 2022 - REMAKE
# Adding overtones (octaves) to the celli
# Based upon of code Dec 30, 2021 and Jan 2, 2022

ns_low = (scale :a2, :major_pentatonic, num_octaves: 2)
coff = 50

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :choir0 do
    coff = 70
    n = sync 'master2cello0'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = 1
    the_att = 0.5
    play ns_low[note],
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns_low[note]+12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns_low[note]+24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
  
  live_loop :choir1 do
    n = sync 'master2cello1'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = 1
    the_att = 0.5
    if length > 4 then
      sleep 2
      play ns_low[note],
        attack: the_att,
        release: length-the_att,
        pan: the_pan,
        cutoff: coff,
        mod_range: 0,
        amp: the_amp
      play ns_low[note] +12,
        attack: the_att,
        release: length-the_att,
        pan: the_pan,
        cutoff: coff,
        mod_range: 0,
        amp: the_amp/2
      play ns_low[note]+24,
        attack: the_att,
        release: length-the_att,
        pan: the_pan,
        cutoff: coff,
        mod_range: 0,
        amp: the_amp/4
    end
  end
end

# by setting master at the end, no empty loop happens
live_loop :master do
  l = (ring 4, 4, 8, 4, 4, 8).tick
  n = rrand_i(0, 9)
  if n > 5 then
    j = n - 3
  else
    j = n + 5
  end
  cue 'master2cello0', n, l, 1
  cue 'master2cello1', j, l, 1
  sleep l
end
