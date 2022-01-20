# 15 Minutes
# 20th of January 2022
# Looking for new voices and patterns
# No idea why something is playing if a non-existent riff is pushed there must be some tolerance kicking in
# Next step: simplifying note and riff to see if I can reproduce

use_debug false

define :cello do |note, length=1, amp=0.5, pan=0.5|
  use_synth :fm
  att = 0.125
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :flute do |note, length=1, amp=1, pan=0|
  use_synth :fm
  att = 0.125
  pause = 0.01
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att-pause, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att-pause, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att-pause, pan: pan, cutoff: note+25, amp: amp/4
  end
  sleep pause
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
  puts riff
  if (riff = 1)
    4.times do
      cello(note+[0, -2, -4].choose, length, 2)
      sleep length
    end
  end
  if (riff = 2)
    cello(note, length, 2)
    sleep length
    cello(note+5, length, 2)
    sleep length
    cello(note-2, length, 2)
    sleep length
    cello(note, length, 2)
    sleep length
  end
  if (riff = 3)
    puts "uuups 3"
    4.times do
      cello(note+rrand_i(-4, 5), length, 2)
      sleep length
    end
  end
end

live_loop :cellos do
  use_bpm 240
  set :n, (ring :c3, :d3, :e3, :f3, :g3).tick(:selectnote)
  set :r, (ring 2, 1, 1, 5).tick(:selectriff)
  puts get[:r]
  celloriff(note=get[:n], riff=get[:r])
end
