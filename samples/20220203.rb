# 15 Minutes
# 3rd of February, 2022
# Missed Yesterday ... completely forgot.
# Let's get some rhythm ... more drums? Nerve killing

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
    play note, attack: att, release: length-att, pan: [-0.25, 0, 0.25].choose, cutoff: note+4, amp: 0.4
  end
end

live_loop :drums do
  use_bpm 240
  3.times do
    sample :tabla_ghe2, amp: 1, cutoff: 90
    sleep 1
  end
  4.times do
    sample :tabla_ke1, amp: 0.5, cutoff: 60 if (spread 5, 7).tick(:tabla)
    sleep 0.25
  end
end
