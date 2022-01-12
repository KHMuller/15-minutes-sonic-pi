# 15 Minutes
# 12th of January 2022
# Low Point - At least figured out how to define a voice as function to be used in master loop

use_debug false
use_bpm 300

define :cello do |note, length=1, amp=1, pan=0.5|
  use_synth :blade
  att = 0.5
  with_fx :reverb, room: 0.5, mix: 0.7 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end


live_loop :master do
  # I can add here any melody by getting l the rhythm and n the notes
  # Curious? Change value of switch ;)
  switch = 0
  
  if switch == 0 then
    l = (ring 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 4, 6, 2).tick(:basemotif)
    l = 1
    n = (scale :a3, :minor, num_octaves: 1).choose
  else
    takt = (ring 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 4, 1, 1, 1, 1, 4, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 4)
    melodie = (ring :c, :d, :e, :f, :g, :g, :a, :a, :a, :a, :g, :a, :a, :a, :a, :g, :f, :f, :f, :f, :e, :e, :d, :d, :d, :d, :c)
    l = takt.tick(:takt)
    n = melodie.tick(:melodie)
  end
  
  cello(n, l, rrand(0.5, 1), rrand(0,0.5))
  sleep l
end


