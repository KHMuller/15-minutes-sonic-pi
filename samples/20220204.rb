# 15 Minutes
# 4th of February, 2022
# Let's get some rhythm ...

use_debug false

define :wave do |note, length=1, amp=1, pan=0|
  use_synth :blade
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 1
  end
end

define :voice do |note, length=1, amp=1, pan=0|
  use_synth :pretty_bell
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: [-0.25, 0, 0.25].choose, cutoff: note+4, amp: amp*0.5
  end
end

live_loop :drums do
  use_bpm 240
  4.times do
    sample :bd_sone, cutoff: rrand_i(60, 100)
    sleep 1
  end
  sample :drum_heavy_kick
  sleep 1
  sample :bd_boom, cutoff: rrand_i(60, 100)
  sleep 1
  sample :drum_cymbal_pedal, amp: rrand(0.75,0.9)
  sleep 1
  sample :drum_cymbal_closed, amp: rrand(0.4,0.6)
  sleep 0.5
  sample :drum_cymbal_closed, amp: rrand(0.4,0.6)
  sleep 0.5
end

used_bpm = 60
cycle_length = 32

notes = [53, 53, 53, 53, 56, 56, 53, 53, 60, 58, 56, 53]
note = notes[0]

used_scales = [:minor]
use_scale = used_scales[0]

live_loop :master do
  speed = 4
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  (cycle_length*speed*2).times do
    ntp = (scale note+12, use_scale, num_octaves = 3).choose
    voice(ntp, 0.5, [0.5, 0.6, 0.7, 0.8, 0.9, 1].choose) if (spread 7, 8).choose
    sleep 0.5
  end
end
