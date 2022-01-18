# 15 Minutes
# 18th of January 2022
# Looking for new voices and patterns
# I can define patterns as functions and then rotate through them lined up as ducks in a row in a ring
# Next step: Add more riffs and more voices


define :cello do |note, length=1, amp=1, pan=0.5|
  use_synth :blade
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.4
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

define :cello1 do |note=:c3, length=1, amp=1, pan=0.5|
  puts "cello1"
  cello(note, length, 2)
  sleep length
  cello(note-2, length, 2)
  sleep length
  cello(note-4, length*2, 2)
  sleep length*2
end

define :cello2 do |note=:c3, length=1, amp=1, pan=0.5|
  puts "cello2"
  cello(note, length, 2)
  sleep length
  cello(note-2, length, 2)
  sleep length
  cello(note+5, length*2, 2)
  sleep length*2
end


variations = (ring cello1, cello1, cello1, cello2)
live_loop :cellos do
  (ring cello1, cello1, cello1, cello2).tick(:mycellos)
  sleep 0.01
end
