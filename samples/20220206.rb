# 15 Minutes
# 6th of February, 2022
# La locura

use_debug false

define :wave do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 1
  end
end

define :voice do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, amp: amp*0.7
  end
end


live_loop :drums do
  use_bpm 240
  4.times do
    sample :bd_sone, cutoff: [40,60,80,100].tick(:cutting), pan: 0.5, amp: [1,1.4,1.6,2].tick(:volumeup)
    sleep 1
  end
  sample :drum_heavy_kick, cutoff: 60, pan: 0.5
  sleep 1
  sample :bd_boom, cutoff: 60, pan: 0.5
  sleep 3
end

used_bpm = 60
cycle_length = 16

notes = [53, 54, 55, 56, 56, 53, 54, 55, 60, 59, 58, 53]
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


live_loop :master3 do
  speed = 4
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c, use_scale, num_octaves = 2).choose
  voice(ntp, 1, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose, 0) if one_in(2)
  sleep 1
end

live_loop :master2 do
  speed = 4
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c+12, use_scale, num_octaves = 2).choose
  voice(ntp, 0.5, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose, 0.25) if one_in(2)
  sleep 0.5
end

live_loop :master do
  speed = 4
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c+24, use_scale, num_octaves = 2).choose
  voice(ntp, 0.5, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose, 0.5)
  sleep 0.5
end
