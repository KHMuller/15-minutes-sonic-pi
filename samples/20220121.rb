# 15 Minutes
# 21st of January 2022
# Looking for new voices and patterns
# Starting to take shape ... having a nice contra bass helps
# No fix found for random note/riff within live_loop

use_debug false

define :contra do |note, length=1, amp=0.5, pan=0.5|
  use_synth :fm
  att = 0.125
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :flute do |note, length=1, amp=1, pan=0|
  use_synth :pretty_bell
  att = 0.125
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :voiceriff do |note=:c3, riff=0, length=1, amp=1, pan=0.5|
  puts riff
  if (riff = 1)
    4.times do
      contra(note+[0, -2, -5, 4].choose, length, 2)
      sleep length
    end
  end
  if (riff = 2)
    contra(note, length, 2)
    sleep length
    contra(note-5, length, 2)
    sleep length
    contra(note-2, length, 2)
    sleep length
    contra(note, length, 2)
    sleep length
  end
  if (riff = 3)
    4.times do
      contra(note+rrand_i(4, -5), length, 2)
      sleep length
    end
  end
end

live_loop :drums do
  use_bpm 60
  cue :contras
  cue :voices
  sleep 1
end

live_loop :contras do
  use_bpm 60
  set :n, (ring :c3, :f3, :g3, :c3).tick(:selectnote)
  set :r, (ring 2, 1, 1, 5).tick(:selectriff)
  puts get[:r]
  voiceriff(note=get[:n], riff=get[:r])
end

live_loop :voices do
  use_bpm 240
  set :n, (ring :c4, :d4, :e4, :f4, :g4, :a4, :b4).shuffle.tick(:selectnotevoice)
  flute(get[:n], 1)
  sleep 1
end
