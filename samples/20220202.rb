# 15 Minutes
# 2nd of January 2022
# Crazy Dance with Cello and Violin
# Next Step: Ramp up and down

ns = (scale :a2, :minor_pentatonic, num_octaves: 3)
coff = 85

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :cello do
    n = sync 'master2cello'
    note =  n[0]
    length = n[1]
    the_pan = (ring 0.5).choose
    the_amp = [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose
    the_att = 0.2
    play ns[note],
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note]+12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
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
    the_amp = [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose
    the_att = 0.1
    play ns[note] + 24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp
    play ns[note]+36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/2
    play ns[note]+48,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      #pan_slide: length,
      cutoff: coff,
      mod_range: 0,
      amp: the_amp/4
  end
end

# by setting master at the end, no empty loop happens
live_loop :master do
  l =(ring 0.125).tick #Change to slow down
  n = rrand_i(0, 9)
  t = 8
  cue 'master2cello', n, l*t
  i = 0
  t.times do
    aug = (ring 0, 3, 5, 7, 9).choose
    cue 'master2violin', n+aug, l
    sleep l
  end
end

