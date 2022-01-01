# 15 Minutes
# 1st of January 2022
# Cello and Violin
# Added overtone to cello and violing ( = cello + 24). I don't really like Cello tone at lower registers
# Next Step: I want to move sound length to master loop to be more flexible with timing


ns = (scale :a2, :major_pentatonic, num_octaves: 2)
coff = 85

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :cello do
    n = sync 'master'
    if n[0] < 4 then
      length = n[0]*4
    else
      length = n[0]
    end
    note = n[1]
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
    n = sync 'master'
    length = n[0]
    note = n[2]
    the_pan = (ring -0.5).choose
    the_amp = [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose
    the_att = 0.2
    play ns[note]+24,
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
  l =(ring 1, 1, 1, 1, 4).tick
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
  if l > 8 then
    sleep l + 1
  else
    sleep l
  end
end

