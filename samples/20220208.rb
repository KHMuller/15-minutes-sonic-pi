# 15 Minutes
# 8th of February, 2022
# Slowing down and speeding up again

use_debug false

define :wave do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :voice do |note, length=1, amp=1, pan=0|
  use_synth :dsaw
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, amp: amp*0.7
  end
end

define :voice1 do |note, length=1, amp=1, pan=0|
  use_synth :pretty_bell
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, amp: amp*0.7
  end
end

live_loop :drums do
  use_bpm 120
  8.times do
    sample :bd_haus, cutoff: [40,60,80,100].tick(:cutting), pan: 0.5, amp: [1,1.4,1.6,2].tick(:volumeup) if (spread 7, 8).tick(:spreadhaus)
    sleep 1
  end
end

used_bpm = 60
cycle_length = 16

notes = [53, 53, 53, 53, 56, 56, 53, 53, 60, 60, 58, 58, 56, 56, 53, 53]
note = notes[0]

used_scales = [:minor]
use_scale = used_scales[0]

live_loop :harmony do
  speed = 4
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  set :currentnote, note
  c = get[:currentnote]
  sleep 4
end

live_loop :master1 do
  speed = 8
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c+12, use_scale, num_octaves = 2).choose
  voice1(ntp, 1, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose, -0.3) if (spread 5, 8).tick(:getsomerhythm)
  sleep 1
end

live_loop :master do
  speed = 4
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c+12, use_scale, num_octaves = 2).choose
  ntp = c
  if one_in(4)
    4.times do
      shift = [0,5,7,9].choose
      voice(ntp+shift, 1, 0.3, 0.3) if (spread 3, 4).choose
      sleep 1
    end
  else
    4.times do
      shift = [0,5,7,9].tick(:shiftup)
      voice(ntp+shift, 1, 0.3, 0.3) #if one_in(2)
      sleep 1
    end
  end
end
