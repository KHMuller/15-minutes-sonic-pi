# 15 Minutes
# 30th of January 2022
# Releasing the voice from tight corset of chords overtime.
# Able to adjust voice scale to underlying chord
# Resolved the if then to work correctly use if (cond) then
# Not setting start value may trigger error to_sym on second loop

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
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: [-0.25, 0, 0.25].choose, cutoff: note+4, amp: 0.4
  end
end

live_loop :drums do
  use_bpm 120
  sleep 4
end

used_bpm = 60
cycle_length = 32

notes = [53, 56, 58, 60, 63, 65, 63, 60, 58, 56]
note = notes[0] # required to set start value

used_scales = [:minor_pentatonic, :minor, :augmented, :chromatic]
use_scale = used_scales[0] # required to set start value

live_loop :master do
  speed = 2
  use_bpm used_bpm*speed
  note = notes.tick(:goup)
  if (note == notes[0]) then
    use_scale = used_scales.tick(:getscale)
    puts 'new scale:', note, use_scale
  end
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
    ntp = (scale note+12, use_scale, num_octaves = 3).choose if (spread 7, 8).tick(:gettingaround)
    voice(ntp, 0.5, 1)
    sleep 0.5
  end
end
