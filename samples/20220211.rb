# 15 Minutes
# 11th of February
# Not bad ;) still ground for improvement though

ns_low = (scale :a2, :major_pentatonic, num_octaves: 2)
coff = 50
use_bpm 60

define :violin do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

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
    play ns_low[note], attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp
    play ns_low[note]+12, attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp/2
    play ns_low[note]+24, attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp/4
  end
  
  live_loop :choir1 do
    n = sync 'master2cello1'
    use_bpm 480
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = 1
    the_att = 0.5
    if length > 4 then
      sleep 2
      play ns_low[note], attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp
      play ns_low[note]+12, attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp/2
      play ns_low[note]+24, attack: the_att, release: length-the_att, pan: the_pan, cutoff: coff, mod_range: 0, amp: the_amp/4
    end
  end
end

# by setting master at the end, no empty loop happens
live_loop :master do
  l = (ring 4, 4, 8, 4, 4, 8, 4, 4, 16).tick(:cellos)
  n = rrand_i(0, 9)
  if n > 5 then
    j = n - 3
  else
    j = n + 5
  end
  cue 'master2cello0', n, l, 1
  cue 'master2cello1', j+12, l, 1
  if one_in(4)
    (l*2).times do
      violin(ns_low[rrand_i(0, 9)]+24, 0.5, 1, 0.3)
      sleep 0.5
    end
  else
    if one_in(4)
      (l*4).times do
        violin(ns_low[rrand_i(0, 9)]+24, 0.25, 1, 0.3) if (spread 3, 4).tick(:violinrhythm)
        sleep 0.25
      end
    else
      (l*8).times do
        violin(ns_low[rrand_i(0, 9)]+24, 0.125, 1, 0.3) if (spread 7, 8).tick(:violinrhythm)
        sleep 0.125
      end
    end
  end
end
