# 15 Minutes
# 26th of January 2022
# Violin on Speed

use_debug false

define :blade do |note, length=1, amp=0.5, pan=0|
  use_synth :fm
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :violin do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

live_loop :drums do
  use_bpm 60
  sample :bd_tek, amp: 0.3, release: 0.125, pitch: 0
  sleep 1
end

curr_bpm = 30
curr_length = 4
ns = (scale :c3, :minor_pentatonic, num_octaves = 2)

live_loop :master0 do
  use_bpm curr_bpm
  
  base = ns.mirror.tick(:goup)
  blade(base, curr_length)
  sleep curr_length
  blade(base+7, curr_length)
  sleep curr_length
end
live_loop :master1 do
  use_bpm curr_bpm
  
  goback = ns.reverse.mirror.tick(:godown)
  blade(goback, curr_length)
  sleep curr_length
  blade(goback-3, curr_length)
  sleep curr_length
end
live_loop :master3 do
  use_bpm curr_bpm
  
  anywhere = ns.mirror.shuffle.tick(:goupanddown)
  blade(anywhere, curr_length)
  sleep curr_length
  blade(anywhere+[-3, 7].choose, curr_length)
  sleep curr_length
end

use_scale = :minor_pentatonic

live_loop :master do
  use_bpm 1200
  nv = (scale :c5, use_scale, num_octaves: 2).choose
  changeamp = 0.6
  drift = [-1,1].choose
  if one_in(8)
    #2.times do
    violin(nv+0*drift, 2, changeamp)
    sleep 2
    violin(nv+2*drift, 2, changeamp)
    sleep 2
    violin(nv+4*drift, 2, changeamp)
    sleep 2
    violin(nv+7*drift, 2, changeamp)
    sleep 2
    violin(nv+7*drift, 2, changeamp)
    sleep 2
    violin(nv+4*drift, 2, changeamp)
    sleep 2
    violin(nv+2*drift, 2, changeamp)
    sleep 2
    violin(nv+0*drift, 2, changeamp)
    sleep 2
    #end
  else
    violin(nv, 4, changeamp)
    sleep 4
    violin(nv+4*drift, 4, changeamp)
    sleep 4
    if one_in(4)
      if one_in(2)
        violin(nv+4*drift, 2, changeamp)
        sleep 2
        violin(nv+5*drift, 2, changeamp)
        sleep 2
        violin(nv+7*drift, 2, changeamp)
        sleep 2
        violin(nv+9*drift, 2, changeamp)
        sleep 2
      else
        violin(nv+4*drift, 2, changeamp)
        sleep 2
        violin(nv+5*drift, 2, changeamp)
        sleep 2
        violin(nv+7*drift, 4, changeamp)
        sleep 4
      end
    else
      violin(nv+5*drift, 4, changeamp)
      sleep 4
      violin(nv+7*drift, 4, changeamp)
      sleep 4
    end
  end
end
