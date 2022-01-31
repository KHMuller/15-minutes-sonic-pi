# 15 Minutes
# 31st of January 2022
# Let's get some drums ... a more drums?

use_debug false

define :wave do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.5
  end
end

define :voice do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: [-0.25, 0, 0.25].choose, cutoff: note+4, amp: 0.4
  end
end

live_loop :drums do
  use_bpm 240
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard, amp: 0.5
  sleep 1
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_pedal, amp: 0.5
  sleep 0.5
end

used_bpm = 60
cycle_length = 32

notes = [53, 53, 53, 53, 56, 56, 53, 53, 60, 58, 55, 53]
note = notes[0] # required to set start value

used_scales = [:minor]
use_scale = used_scales[0] # required to set start value

live_loop :master do
  speed = 4
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  if one_in(2)
    wave(note, cycle_length*speed, 1, -0.5)
    wave(note-5, cycle_length*speed, 1, 0.5)
    wave(note-8, cycle_length*speed, 1, 0.5)
  else
    wave(note, cycle_length*speed, 1, -0.5)
    wave(note+3, cycle_length*speed, 1, 0.5)
    wave(note+7, cycle_length*speed, 1, 0.5)
  end
  (cycle_length*speed*2).times do
    ntp = (scale note+12, use_scale, num_octaves = 3).choose if (spread 15, 16).choose
    voice(ntp, 0.5, 1)
    sleep 0.5
  end
end
