# 15 Minutes
# 24th of January 2022
# A new start - Skip this one ... work in progress

use_debug false

define :blade do |note, length=1, amp=1, pan=0|
  use_synth :prophet
  att = length - 1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

live_loop :drums do
  use_bpm 30
  sample :bd_tek, amp: 0.5, release: 0.125, pitch: 0
  sleep 1
end

live_loop :master do
  use_bpm 240
  base = [60, 62, 64, 57].tick(:goaround)
  blade(base, 8)
  sleep 2
  blade(base+4, 8)
  sleep 2
  blade(base+7, 8)
  sleep 2
  blade(base+9, 8)
  sleep 8
end
