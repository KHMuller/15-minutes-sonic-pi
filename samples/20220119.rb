# 15 Minutes
# 19th of January 2022
# Looking for new voices and patterns
# I am trying to randomly select a note and a riff and play the combination once per live loop.
# But when I set the note and the riff, the script runs through the ring of riffs and plays them
# With one function that plays the note with a specific riff it works if riff is second variable
# Still riff 0 even if not a choice?
# I lack understanding how these variables are set and modified while looping.

use_debug false

define :cello do |note, length=1, amp=1, pan=0.5|
  use_synth :blade
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.4
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :cello1 do |note=:c3, length=1, amp=1, pan=0.5|
  puts note
  cello(note, length, 2)
  sleep length
  cello(note-2, length, 2)
  sleep length
  cello(note-4, length*2, 2)
  sleep length*2
end

define :cello2 do |note=:c3, length=1, amp=1, pan=0.5|
  puts note
  cello(note, length, 2)
  sleep length
  cello(note-2, length, 2)
  sleep length
  cello(note+5, length*2, 2)
  sleep length*2
end

define :cello3 do |note=:c3, length=1, amp=1, pan=0.5|
  puts note
  cello(note, length, 2)
  sleep length
  cello(note+5, length, 2)
  sleep length
  cello(note-2, length*2, 2)
  sleep length*2
end

define :celloriff do |note=:c3, riff=0, length=1, amp=1, pan=0.5|
  if (riff = 0) then
    puts riff
    cello(note, length, 2)
    sleep length
    cello(note-2, length, 2)
    sleep length
    cello(note-4, length*2, 2)
    sleep length*2
  end
  if (riff = 1) then
    puts riff
    cello(note, length, 2)
    sleep length
    cello(note-2, length, 2)
    sleep length
    cello(note-4, length*2, 2)
    sleep length*2
  end
  if (riff = 2) then
    puts "uups"
  end
end

live_loop :cellos do
  use_bpm 60
  set :n, (ring :c3, :d3, :e3).tick(:selectnote)
  set :r, [1,2].choose
  celloriff(note=get[:n], riff=get[:r])
  sleep 1
end



