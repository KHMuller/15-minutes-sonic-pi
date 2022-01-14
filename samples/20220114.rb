# 15 Minutes
# 14th of January 2022
# Playing with scales from c1 to c4 on flute (?)
# Listen to it on https://muuuh.com/sounds/ 


use_debug false
set :bpm, 300

a = (ring 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1).mirror


define :flute do |note, length=1, amp=1, pan=0.5|
  #with_fx :reverb, room: 0.3, mix: 0.4 do
  use_synth :pretty_bell
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.5
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
  #end
end

define :cello do |note, length=1, amp=1, pan=0.5|
  #with_fx :reverb, room: 0.3, mix: 0.4 do
  use_synth :blade
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.5
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
  #end
end


define :organ do |note, length=1, amp=1, pan=0.5|
  #with_fx :reverb, room: 0.3, mix: 0.4 do
  use_synth :sine
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.5
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
  #end
end

live_loop :base do
  use_bpm 60 #change to 1200
  l = 8
  n = (scale :c2, :minor, num_octaves: 1).choose
  #cello(n, l, 4, rrand(-0.5,0))
  sleep l
end


live_loop :drums do
  use_bpm 60
  sample :bd_tek, amp: 1, release: 0.125, pitch: 0
  sleep 1
end



live_loop :master do
  use_bpm 1200
  # I can add here any melody by getting l the rhythm and n the notes
  # Curious? Change value of switch ;)
  switch = 0
  
  a = (ring 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1).mirror
  
  if switch == 0 then
    l = (ring 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 4, 6, 2).tick(:basemotif)
    l = 1*2
    n_n = (scale :c1, :minor, num_octaves: 1).choose
    n = (scale :c3, :minor, num_octaves: 2).choose
    n_h = (scale :c4, :minor, num_octaves: 1).choose
    n_l = (scale :c2, :minor, num_octaves: 1).choose
    n_s = (scale :c4, :minor, num_octaves: 1).choose
  else
    takt = (ring 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 4, 1, 1, 1, 1, 4, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 4)
    melodie = (ring :c, :d, :e, :f, :g, :g, :a, :a, :a, :a, :g, :a, :a, :a, :a, :g, :f, :f, :f, :f, :e, :e, :d, :d, :d, :d, :c)
    l = takt.tick(:takt)
    n = melodie.tick(:melodie)
    ##| l = takt.choose
    ##| n = melodie.choose
  end
  
  #organ(n_n, l, 0.5+a.choose, rrand(-0.5,0)) if (spread 4, 4).tick(:cellobeat)
  sleep l
end


