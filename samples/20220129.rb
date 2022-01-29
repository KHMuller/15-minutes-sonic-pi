# 15 Minutes
# 29th of January 2022
# Difficult to get the cycles in sync ...
# I want to adjust scale of voice based on selected note on master

use_debug false

define :blade do |note, length=1, amp=1, pan=0|
  use_synth :dsaw
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.6
  end
end

define :violin do |note, length=1, amp=1, pan=0|
  use_synth :pretty_bell
  att = length/2
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: 0.6
  end
end

live_loop :drums do
  use_bpm 60
  sample :bd_tek, amp: 0.5, release: 0.125, pitch: 0
  sleep 1
end

curr_bpm = 60
curr_length = 32
use_scale = :minor

ns = (scale :c3, use_scale, num_octaves = 1)
live_loop :master do
  use_bpm curr_bpm
  base = ns.choose #mirror.tick(:goup)
  cue 'master2voice', base
  if one_in(2)
    blade(base, curr_length, 1, -0.5)
    blade(base-5, curr_length, 1, 0.5)
    sleep curr_length
  else
    blade(base, curr_length, 1, -0.5)
    blade(base+5, curr_length, 1, 0.5)
    sleep curr_length
  end
end

live_loop :voice do
  speed = 4
  use_bpm curr_bpm*speed
  getcue = sync "/cue/master2voice"
  sleep speed
  (64*speed-6*speed).times do
    ntp = (scale getcue[0]+24, use_scale, num_octaves = 2).choose
    violin(ntp, 0.5, 0.5)
    sleep 0.5
  end
end
