#
# Für Alina by Arvo Pärt - Sonic Pi - house version - arrangement by Christ Leijtens
#
# Total music 111 beats.
# Total including start of background sound 119 beats (4 beats piano / 107 beats synth.
# Total including fade-out of background 120 beats.
#
# Call as: fur_alina_house <n> <synth>
#
# <n> - the number of beats to start the backround sound in advance of the music, should be a multiple of 4.
# Best synth's: :dark_ambience and :hollow.
#



define :fur_alina_house_background_sound do | n |
  
  in_thread(name: clitc_thread_prefix + "background") do
    
    in_thread do
      n.times do
        sample :ambi_haunted_hum, amp: 0.5
        sleep 4
      end
    end
    
  end
  
end # define :fur_alina_house_background_sound



define :fur_alina_house_melody do | my_synth, volume |
  
  fur_alina_score = [
    [:Cs5, :B4], [:D5, :B4], # bar 2
    [:E5, :D5], [:Fs5, :D5], [:Fs5, :D5], # bar 3
    [:E5, :D5], [:D5, :B4], [:Cs5, :B4], # bar 4
    [:B4, :Fs4], # bar 5
    [:Fs5, :D5], [:E5, :D5], [:Fs5, :D5], [:D5, :B4], # bar 6
    [:E5, :D5], # bar 7
    [:D5, :B4], [:Fs5, :D5], [:B5, :Fs5], [:Cs6, :B5], [:B5, :Fs5], # bar 8
    [:D5, :B4], # bar 9
    [:E5, :D5], [:D5, :B4], [:B4, :Fs4], [:D5, :B4], [:Fs5, :D5], [:D5, :B4], # bar 10
    [:E5, :D5], # bar 11
    [:Fs5, :D5], [:D6, :B5], [:Cs6, :B5], [:B5, :Fs5], # bar 12
    [:B4, :Fs4], [:Fs5, :D5], [:G5, :Fs5], # bar 13
    [:A5, :Fs5], # bar 14
    [:D5, :B4], [:E5, :D5], [:B4, :Fs4], [:Cs5, :B4], [:D5, :B4], [:Cs5, :B4], # bar 15
    [:B4, :Fs4], # bar 16
    [:A5, :Fs5], [:G5, :Fs5], [:A5, :Fs5], [:B4, :Fs4], [:Cs5, :B4], # bar 17
    [:Fs5, :D5], # bar 18
    [:G5, :Fs5], [:D5, :B4], [:E5, :D5], [:Fs5, :D5], # bar 19
    [:Fs5, :Cs5], # bar 20
    [:D5, :B4], [:Cs5, :Fs4], [:D4, :B3], # bar 21
    [:E4, :D4], # bar 22
    [:B3, :Fs3], [:Fs4, :D4], [:D5, :B4], # bar 23
    [:B4, :Fs4], [:D4, :B3], # bar 24
    [:B4, :Fs4], [:Cs5, :B4], [:B4, :Fs4] # bar 25
  ]
  
  # total 107 beats
  fur_alina_timings = [
    1, 4, # 5 beats
    1, 1, 4, # 6 beats / 11 beats
    1, 1, 1, # 3 beats / 14 beats
    4, # 4 beats / 18 beats
    1, 1, 1, 1, # 4 beats / 22 beats
    4, # 4 beats / 26 beats
    1, 1, 1, 1, 1, # 5 beats / 31 beats
    4, # 4 beats / 35 beats
    1, 1, 1, 1, 1, 1, # 6 beats / 41 beats
    4, # 4 beats / 45 beats
    1, 1, 1, 1, # 4 beats / 49 beats
    1, 1, 1, # 3 beats / 52 beats
    4, # 4 beats / 56 beats
    1, 1, 1, 1, 1, 1, # 6 beats / 62 beats
    4, # 4 beats / 66 beats
    1, 1, 1, 1, 1, # 5 beats / 71 beats
    4, # 4 beats / 75 beats
    1, 1, 1, 1, # 4 beats / 79 beats
    4, # 4 beats / 83 beats
    1, 1, 1, # 3 beats / 86 beats
    4, # 4 beats / 90 beats
    1, 1, 4, # 6 beats / 96 beats
    1, 4, # 5 beats / 101 beats
    1, 1, 4 # 6 beats / 107 beats
  ]
  
  in_thread(name: clitc_thread_prefix + "melody") do
    
    with_synth :piano do
      with_fx :reverb, mix: 1.0, room: 1 do
        play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1, sustain: 20
        sleep 4
      end
    end
        
    with_synth my_synth do
      with_fx :reverb, mix: 1.0, room: 0.5 do
        play_pattern_timed fur_alina_score, fur_alina_timings, amp: volume, attack_level: 3, attack: 0.5, sustain: 4
      end
    end
    
  end
  
end # define :fur_alina_house_melody



define :fur_alina_house_rhythm do |volume, n|
  
  with_fx :pan, pan: 0, amp: volume do
    
    sample :bd_boom, pan: -1
    sleep 1
    
    (n - 1).times do
      sample :bd_klub, pan: 1
      sleep 1
    end
    
  end
  
end # define :fur_alina_house_rhythm



define :fur_alina_house_rhythm_line do
  
  fur_alina_drums_timings = [
    5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6 # 107 beats
  ]
  
  sleep 0.3
  
  in_thread(name: clitc_thread_prefix + "drum") do
    
    sleep 4
    
    tick_reset
    
    fur_alina_drums_timings.each do
      fur_alina_house_rhythm 2, fur_alina_drums_timings[tick]
    end
    
  end
  
end # define :fur_alina_house_rhythm_line



define :fur_alina_house do | fah_config |
  
  use_bpm fah_config["bpm"]
  
  n_bg_repeat = 28 + (fah_config["delay"] / 4).ceil
  
  puts "n_bg_repeat = " + n_bg_repeat.to_s
  
  fur_alina_house_background_sound n_bg_repeat
  
  sleep fah_config["delay"]
  fur_alina_house_melody fah_config["synth"], fah_config["volume"]
  
  fur_alina_house_rhythm_line
    
  sleep ( 111 + fah_config["delay"] )
  
end # define :fur_alina_house
