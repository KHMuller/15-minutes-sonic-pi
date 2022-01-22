# 15 Minutes
# 22nd of January 2022
# Looking for new voices and patterns
# Dropped the riff function because of the ghost riff
# Not really a flute though more of a xylophone

use_debug false

define :contra do |note, length=1, amp=0.5, pan=0.2|
  use_synth :fm
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

define :flute do |note, length=1, amp=0.7, pan=-0.2|
  use_synth :pretty_bell
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end

live_loop :drums do
  use_bpm 60
  cue :contras
  cue :voices
  sample :bd_tek, amp: 1, release: 0.125, pitch: 0, amp: 1
  sleep 0.25
  sample :drum_heavy_kick, rate: 0.75, amp: 0.4
  sleep 0.25
  sample :drum_heavy_kick, rate: 0.5, amp: 0.4
  sleep 0.5
end

live_loop :contras do
  use_bpm 120
  3.times do
    set :n, (ring :c3, :f3, :g3).tick(:selectnotecontras)
    4.times do
      contra(get[:n]+(ring 0, 4, 7, 10).shuffle.tick(:contrariffup), 1, 2)
      sleep 1
    end
  end
  4.times do
    contra(:c3+(ring 7, 5, 4, 2).tick(:contrariffdown), 1, 2)
    sleep 1
  end
end

live_loop :voices do
  use_bpm 240
  a = one_in(4)
  if a
    4.times do
      set :nflute, (scale :c3, :minor_pentatonic, num_octaves: 2).shuffle.tick(:selectnotevoice)
      flute(get[:nflute], 0.5)
      sleep 0.5
    end
  else
    set :nflute, (scale :c3, :minor_pentatonic, num_octaves: 2).shuffle.tick(:selectnotevoice)
    flute(get[:nflute], 1)
    sleep 1
  end
end
