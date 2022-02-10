# 15 Minutes
# 10th of February, 2022
# Something I can build up again
# Recorded and published https://muuuh.com/sounds/
# Name?

use_debug false

define :wave do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end


define :organ do |note, length=1, amp=1, pan=0.5|
  use_synth :fm
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

define :voice do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, amp: amp*1.7, cutoff: 90
    play note+12, attack: att, release: length-att, pan: pan, amp: amp*1.7, cutoff: 90
    play note+24, attack: att, release: length-att, pan: pan, amp: amp*1.7, cutoff: 90
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
  sample :bd_sone, cutoff: 60, pan: 0.5, amp: 2
  sleep 1
  
  sample :bd_zum, cutoff: 40, pan: 0.5, amp: 2
  sleep 1
  sleep 1
  
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
end

used_bpm = 60
cycle_length = 16

notes = [53, 53, 53, 53, 58, 58, 53, 53, 58, 58, 53, 53, 60, 60, 58, 58, 55, 55, 53, 53]
note = notes[0]

used_scales = [:major_pentatonic]
use_scale = used_scales[0]

live_loop :harmony do
  speed = 4
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  set :currentnote, note
  c = get[:currentnote]
  sleep 4
end


live_loop :master do
  speed = 8
  use_bpm used_bpm*speed
  c = get[:currentnote]
  ntp = (scale c+24, use_scale, num_octaves = 2).choose
  ntp = c
  voice1((scale ntp, use_scale, num_octaves = 4).choose, 1, [0.6,0.8,0.9].choose, 0.3)
  organ(c, 1, 1, 0.5) if (spread 7, 8).tick(:basetick)
  sleep 1
end
