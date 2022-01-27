# 15 Minutes
# 27th of January 2022
# Organ Virtuoso
# Next Get the voice play in harmony with the base

use_debug false

define :blade do |note, length=1, amp=0.2, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.8
  end
end

define :violin do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = 0.3
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.4
  end
end

live_loop :drums do
  use_bpm 30
  sample :bd_tek, amp: 0.3, release: 0.125, pitch: 0
  sleep 1
end

curr_bpm = 60
curr_length = 8
use_scale = :minor

ns = (scale :c3, use_scale, num_octaves = 1)
live_loop :master do
  use_bpm curr_bpm
  base = ns.mirror.tick(:goup)
  if one_in(4)
    blade(base, curr_length)
    blade(base-5, curr_length)
    blade(base-8, curr_length)
    sleep curr_length
  else
    blade(base, curr_length)
    blade(base+7, curr_length)
    blade(base+4, curr_length)
    sleep curr_length
  end
end

live_loop :voice do
  use_bpm 600
  nv = (scale :c4, use_scale, num_octaves: 1).choose
  changeamp = 0.6
  drift = [-1,1,1].choose
  if (drift < 0)
    if one_in(16)
      violin(nv+12+3*drift, 2, changeamp)
      sleep 2
      violin(nv+12+5*drift, 2, changeamp)
      sleep 2
      violin(nv+12+7*drift, 2, changeamp)
      sleep 2
      violin(nv+12+8*drift, 2, changeamp)
      sleep 2
      violin(nv+12, 4, changeamp)
      sleep 4
      violin(nv+12+8*drift, 4, changeamp)
      sleep 4
      violin(nv+12, 16, changeamp)
      sleep 16
      sleep 16
    else
      if one_in(8)
        violin(nv+12+12*drift, 2, changeamp)
        sleep 2
        violin(nv+12+10*drift, 2, changeamp)
        sleep 2
        violin(nv+12+8*drift, 2, changeamp)
        sleep 2
        violin(nv+12+5*drift, 2, changeamp)
        sleep 2
        violin(nv+12+5*drift, 2, changeamp)
        sleep 2
        violin(nv+12+8*drift, 2, changeamp)
        sleep 2
        violin(nv+12+10*drift, 2, changeamp)
        sleep 2
        violin(nv+12+12*drift, 2, changeamp)
        sleep 2
      else
        8.times do
          violin(nv+12+[12, 10, 8, 5].choose*drift, 2, changeamp)
          sleep 2
        end
      end
    end
  else
    if one_in(16)
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
    else
      8.times do
        violin(nv+12+[0, 2, 4, 7].choose*drift, 2, changeamp)
        sleep 2
      end
    end
  end
end
