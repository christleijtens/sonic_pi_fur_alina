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
  
  fur_alina_score = get[:fur_alina_score]
  
  # total 107 beats
  fur_alina_timings = get[:fur_alina_timings]
  
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



define :fur_alina_house_rhythm_line do | volume |
  
  sleep 0.3
  
  fur_alina_drums_timings = get[:fur_alina_drums_timings]
  
  in_thread(name: clitc_thread_prefix + "drum") do
    
    sleep 4
    
    tick_reset
    fur_alina_drums_timings.each do
      fur_alina_house_rhythm volume, fur_alina_drums_timings[tick]
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
  
  fur_alina_house_rhythm_line fah_config["volume_drums"]
  
  sleep ( 111 + fah_config["delay"] )
  
end # define :fur_alina_house
