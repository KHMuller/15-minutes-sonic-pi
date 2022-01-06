# 15 Minutes
# 6th of January 2022
# Adding Violin for a Duet for Cello and Violin
# Failed overtones *2, *3, *4 (too high frequency)
# Next Step: Fix violin sound and tick/look/choose

ns_low = (scale :a2, :minor, num_octaves: 2)
coff = 50

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :violin do
    n = sync 'master2violin'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = n[2]
    the_att = 0.05
    coff = ns_low[note]+48
    play ns_low[note] + 24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns_low[note] +36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns_low[note]+48,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
  
  live_loop :choir0 do
    n = sync 'master2cello0'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = 1
    the_att = 0.5
    coff = ns_low[note] + 24 + 1
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

live_loop :master do
  # select length and base note
  l = (ring 4, 4, 8, 4, 4, 8).tick
  n = rrand_i(0, 9)
  
  cue 'master2cello0', n, l, 1
  puts l
  # shift within scale
  shift = (ring -7, -6, -5, -4, -3, -2, -1, 0, +1, +2, +3, +4, +5, +6, +7)
  if l == 8 then
    64.times do
      cue 'master2violin', n + shift.choose, 0.125, 1
      sleep 0.125
    end
  else
    32.times do
      cue 'master2violin', n + shift.tick, 0.125, 1
      sleep 0.125
    end
  end
  sleep 0.125
end
