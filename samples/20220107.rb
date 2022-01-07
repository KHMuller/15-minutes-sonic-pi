# 15 Minutes
# 7th of January 2022
# Asking Violin to Play Motifs over Scale
# Able to get the ticks right with named ticks
# Violin is now playing a motif :)
# Next step: Get the timing of violing and cello aligned, refactoring

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

motifs = (ring
          (ring 0.0625, 0.0625, 0.375, 0.25, 0.0625, 0.0625, 0.375, 0.25),
          (ring 0.25, 0.125, 0.25, 0.125, 0.25, 0.125, 0.25, 0.125),
          (ring 0.125),
          )

live_loop :aloop do
  tick_set :motif, 0
  tick_set :shift, 0
  shift = (ring 0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1, 0)
  n = sync :violinmotif, n
  
  
  total = 0
  while (total < 4)
    motif = motifs.choose
    8.times do
      l =  motif.tick(:motif)
      total = total + l
      cue 'master2violin', n[0] + shift.choose, l, 1
      sleep l
    end
  end
end


live_loop :master do
  # select length and base note
  tick
  l = (ring 4, 4, 8, 4, 4, 8).look
  n = rrand_i(0, 9)
  
  cue 'master2cello0', n, l, 1
  puts l
  shift = (ring -7, -6, -5, -4, -3, -2, -1, 0, +1, +2, +3, +4, +5, +6, +7)
  
  if l == 8 then
    cue 'playing 64 times ------------------------- 64 Better Debug'
    64.times do
      cue 'master2violin', n + shift.choose, 0.125, 1
      sleep 0.125
    end
  else
    cue 'playing 32 times ------------------------- 32 Better Debug'
    cue :violinmotif, n, 1, 1
    sleep l
  end
  sleep 0.125
end
