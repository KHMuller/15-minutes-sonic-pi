# 15 Minutes
# 5th of February, 2022
# Don't try this one ... work in progress.

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
    play note, attack: att, release: length-att, pan: [-0.25, 0, 0.25].choose, amp: amp*0.7
  end
end

live_loop :drums do
  use_bpm 240
  4.times do
    sample :bd_sone, cutoff: [40,60,80,100].tick(:cutting), pan: 0.5, amp: [1,1.4,1.6,2].tick(:scaledown)
    sleep 1
  end
  sample :drum_heavy_kick, cutoff: 60, pan: 0.5
  sleep 1
  sample :bd_boom, cutoff: 60, pan: 0.5
  sleep 3
end

used_bpm = 60
cycle_length = 32

notes = [53, 53, 53, 53, 56, 56, 53, 53, 60, 58, 56, 53]
note = notes[0]

used_scales = [:minor]
use_scale = used_scales[0]

live_loop :harmony do
  sync "/set/currentnote"
  c = get[:currentnote]
  puts (chord c, '+5')
  use_synth :blade
  4.times do
    play_chord (chord c, '7'), release: 2, cutoff: 80, amp: 2
    sleep 3
    play_chord (chord c, '7-13'), release: 0.5, cutoff: 80, amp: 2
    sleep 1
  end
  play_chord (chord c, '7-9'), release: 7, cutoff: 80, amp: 2
  sleep 8
end


live_loop :master do
  speed = 4
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  set :currentnote, note
  (cycle_length*speed*2).times do
    ntp = (scale note+12, use_scale, num_octaves = 3).choose
    voice(ntp, 0.5, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose) if (spread 7, 8).choose
    sleep 0.5
  end
end
