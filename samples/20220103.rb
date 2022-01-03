# 15 Minutes
# 3rd of January 2022
# Contra, Cello and Violong and Violin - Sounds now like Church Organ
# Next Step: Get tick to speed up/down and/or volume up/down


ns = (scale :g2, :major_pentatonic, num_octaves: 3)
coff = 85

use_debug = false

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :contra do
    n = sync 'master2contra'
    note =  n[0]
    length = n[1]
    the_pan = (ring 0.5).choose
    the_amp = n[2]
    the_att = 0.05
    play ns[note]-12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note],
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
    sleep length
  end
  
  
  live_loop :cello do
    n = sync 'master2cello'
    note =  n[0]
    length = n[1]
    the_pan = (ring 0.5).choose
    the_amp = n[2]
    the_att = 0.05
    play ns[note],
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note]+12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
    sleep length
  end
  
  live_loop :violin do
    n = sync 'master2violin'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = n[2]
    the_att = 0.05
    play ns[note] + 24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note]+36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+48,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
  
  live_loop :violon do
    n = sync 'master2violon'
    note = n[0]
    length = n[1]
    the_pan = (ring 0).choose
    the_amp = n[2]
    the_att = 0.05
    play ns[note] + 12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note]+36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+48,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
  
end

# by setting master at the end, no empty loop happens
# Example ramp with range
##| rampwithrange = (ramp *range(0, 0.125, 0.025))
##| rampwithvalues = (ramp 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 0)
down = (ramp *range(1, 0, 0.001))
live_loop :master do
  l = 0.125+0.025*-1
  n = rrand_i(0, 9)
  t = 8
  v = 1
  cue 'master2contra', n, l*t, 1*v
  i = 0
  t.times do
    aug = (ring 3, 5, 6, 0)
    cue 'master2violin', n+aug.choose, l, 1*v
    cue 'master2violon', n+aug.choose, l, 1*v
    cue 'master2cello', n+aug.choose, l, 1*v
    sleep l
  end
end

