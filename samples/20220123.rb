# 15 Minutes
# 23rd of January 2022
# Looking for new voices and patterns found contra bass, xylophone and keyboard
# Next step: I want to hear a violin again playing scales over given chord progression

use_debug false

define :contra do |note, length=1, amp=1, pan=0.2|
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

define :piano do |note, length=1, amp=0.7, pan=0.5|
  use_synth :piano
  att = 0.1
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play_chord [note, note+4, note+7], attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
  end
end


live_loop :drums do
  use_bpm 60
  cue :contras
  cue :voices
  cue :chords
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
      contra(get[:n]+(ring 0, 4, 7, 10).tick(:contrariffup), 1, 0.5)
      sleep 1
    end
  end
  4.times do
    contra(:c3+(ring 7, 5, 4, 2).tick(:contrariffdown), 1, 0.5)
    sleep 1
  end
end

live_loop :chords do
  use_bpm 120
  3.times do
    set :basechord, (ring :c4, :f4, :g4, :c4).tick(:selectnotecontras)
    sleep 0.5
    base = get[:basechord]
    piano(base, 4, 2)
    sleep 3.5
  end
  set :basechord, (ring :c4, :f4, :g4, :c4).tick(:selectnotecontras)
  base = get[:basechord]
  piano(base, 4, 2)
  sleep 0.5
  piano(base, 4, 2)
  sleep 3.5
end

live_loop :voices do
  use_bpm 240
  a = one_in(4)
  if a
    4.times do
      set :nflute, (scale :c4, :minor_pentatonic, num_octaves: 3).shuffle.tick(:selectnotevoice)
      flute(get[:nflute], 0.5)
      sleep 0.5
    end
  else
    2.times do
      set :nflute, (scale :c4, :minor_pentatonic, num_octaves: 3).shuffle.tick(:selectnotevoice)
      flute(get[:nflute], 1)
      sleep 1
    end
  end
end
