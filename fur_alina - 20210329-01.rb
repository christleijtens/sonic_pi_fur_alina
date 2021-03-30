use_debug false
set_volume! 1

base_bpm = 80
use_bpm base_bpm

home_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
samps_dir = home_dir + "samps/"

define :rhythm do |volume, n|
  
  with_fx :pan, pan: 0, amp: volume do
    
    sample :ambi_drone, pitch: -12
    sample :bd_tek, pan: -1
    sleep 1
    
    (n - 1).times do
      sample :bd_haus, pan: 1
      sleep 1
    end
    
  end
  
end

instruments_arr = [
  {
    instrument: "celesta-e5-hard-PB.wav",
    note: ":E5",
    vol: "1.0"
  },
  {
    instrument: "cello-sustain-4_Db-PB-loop.wav",
    note: ":Db4",
    vol: "0.1"
  },
  {
    instrument: "tubularbells-4_Eb_p.wav",
    note: ":Eb4",
    vol: "0.4"
  },
  {
    instrument: "cello-vibrato-4_Bb-PB.wav",
    note: ":Bb4",
    vol: "0.1"
  },
  {
    instrument: "cello-tremulo-4_D_t-PB-loop.wav",
    note: ":D4",
    vol: "0.5"
  },
  {
    instrument: "cor-anglais-f4-PB-loop.wav",
    note: ":F4",
    vol: "0.5"
  }
]



#
# Below code (:playwavnote) is from Joe McCarty.
#   (https://in-thread.sonic-pi.net/u/joemac/summary)
#

instrument_map = instruments_arr[0]
instrument_samp = samps_dir + instrument_map[:instrument]
instrument_note = instrument_map[:note]
instrument_vol = instrument_map[:vol]

halftone = Math.log(2.0) / 12.0
octtone = Math.log(2.0)
centtone = halftone / 100.0
tempo = 1.0

print ""
print "  > Für Alina by Arvo Pärt a Sonic Pi version..."
print "    - Sample: " + instrument_map[:instrument] + ", volume: " + instrument_vol.to_s
print ""

define :playwavnote do |samp, samp_pitch, pitch, time, cents = 0.0, amp = 1.0, pan = 0.0|
  
  a = note samp_pitch
  if a != nil
    
    b = note pitch
    
    if b != nil
      
      r = Math.exp( (b - a) * halftone + cents * centtone)
      sample samp, rate: r, attack: 0.1,
        sustain: tempo * time * 1,
        release: tempo * time * 2.0 / 3.0, amp: amp , pan: pan
      
    end
  end
  
  sleep tempo * time
  
end # define :playwavenote



define :ambient_tropical_sea do
  
  in_thread(name: :background) do
    
    in_thread do
      loop do
        sample :ambi_haunted_hum, amp: 0.3
        sample :vinyl_hiss, amp: 1
        sleep 4
      end
    end
    
    in_thread do
      loop do
        sample samps_dir + "gulfwaves.wav", amp: 0.2, pan: -1 # length 62 seconds
        sleep ( current_bpm / 60 ) * 62
      end
    end
    
    in_thread do
      loop do
        sample samps_dir + "tropical-forrest.wav", amp: 0.2, pan: 1 # length 154 seconds
        sleep ( current_bpm / 60 ) * 154
      end
    end
    
  end
  
end # define :ambient_tropical_sea



define :fur_alina do
  
  fur_alina_right_hand = [
    :r,
    :Cs5, :D5,
    :E5, :Fs5, :Fs5,
    :E5, :D5, :Cs5,
    :B4,
    :Fs5, :E5, :Fs5, :D5,
    :E5,
    :D5, :Fs5, :B5, :Cs6, :B5,
    :D5,
    :E5, :D5, :B4, :D5, :Fs5, :D5,
    :E5,
    :Fs5, :D6, :Cs6, :B5,
    :B4, :Fs5, :G5,
    :A5,
    :D5, :E5, :B4, :Cs5, :D5, :Cs5,
    :B4,
    :A5, :G5, :A5, :B4, :Cs5,
    :Fs5,
    :G5, :D5, :E5, :Fs5,
    :Fs5,
    :D5, :Cs5, :D4,
    :E4,
    :B3, :Fs4, :D5,
    :B4, :D4,
    :B4, :Cs5, :B4
  ]
  
  fur_alina_left_hand = [
    :r,
    :B4, :B4,
    :D5, :D5, :D5,
    :D5, :B4, :B4,
    :Fs4,
    :D5, :D5, :D5, :B4,
    :D5,
    :B4, :D5, :Fs5, :B5, :Fs5,
    :B4,
    :D5, :B4, :Fs4, :B4, :D5, :B4,
    :D5,
    :D5, :B5, :B5, :Fs5,
    :Fs4, :D5, :Fs5,
    :Fs5,
    :B4, :D5, :Fs4, :B4, :B4, :B4,
    :Fs4,
    :fs5, :Fs5, :Fs5, :Fs4, :B4,
    :D5,
    :Fs5, :B4, :D5, :D5,
    :Cs5,
    :B4, :Fs4, :B3,
    :D4,
    :Fs3, :D4, :B4,
    :Fs4, :B3,
    :Fs4, :B4, :Fs4
  ]
  
  # total 111 beats
  fur_alina_timings = [
    4, # 4 beats
    1, 4, # 5 beats
    1, 1, 4, # 6 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    4, # 4 beats
    1, 1, 1, 1, 1, # 5 beats
    4, # 4 beats
    1, 1, 1, 1, 1, 1, # 6 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 1, 1, 1, 1, # 6 beats
    4, # 4 beats
    1, 1, 1, 1, 1, # 5 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    4, # 4 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 4, # 6 beats
    1, 4, # 5 beats
    1, 1, 4 # 6 beats
  ]
  
  fur_alina_drums_timings = [
    4, 5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6
  ]
  
  in_thread(name: :melody) do
    
    shift_melody_right = 0
    shift_melody_left = 0
    new_bpm = 60
    
    in_thread(name: :bass) do
      loop do
        with_synth :piano do
          with_fx :reverb, mix: 1.0, room: 1 do
            play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1
          end
        end
        sync :round
      end
    end
    
    in_thread(name: :right) do
      loop do
        
        use_bpm new_bpm
        with_fx :reverb, mix: 1, room: 0.5, amp: 2.0 do
          
          tick_reset
          
          fur_alina_right_hand.each do
            tick
            puts "Note right hand: " + fur_alina_right_hand[look].to_s
            playwavnote instrument_samp, instrument_note,
              fur_alina_right_hand[look] + shift_melody_right,
              fur_alina_timings[look], 0.0, instrument_vol
          end
        end
        
        shift_melody_right = choose([-12, 0, 12])
        
        puts "Shift right hand: " + shift_melody_right.to_s
        
        new_bpm = base_bpm + choose([-10, -5, 0, 5, 10])
        
        puts "Set tempo to: " + new_bpm.to_s
        
        instrument_map = instruments_arr.choose
        instrument_samp = samps_dir + instrument_map[:instrument]
        instrument_note = instrument_map[:note]
        instrument_vol = instrument_map[:vol]
        
        puts "    - Sample: " + instrument_map[:instrument] + ", volume: " + instrument_vol.to_s
        
        cue :round
      end
    end
    
    in_thread(name: :left) do
      
      loop do
        
        use_bpm new_bpm
        with_fx :reverb, mix: 1, room: 0.5, amp: 2.0 do
          
          tick_reset
          
          fur_alina_left_hand.each do
            tick
            puts "Note left hand: " + fur_alina_left_hand[look].to_s
            playwavnote instrument_samp, instrument_note,
              fur_alina_left_hand[look] + shift_melody_left,
              fur_alina_timings[look], 0.0, instrument_vol
          end
        end
        
        shift_melody_left = choose([-12, 0, 12])
        
        puts "Shift left hand: " + shift_melody_left.to_s
        
        sync :round
      end
    end
    
    in_thread(name: :drum) do
      
      loop do
        
        use_bpm new_bpm
        
        tick_reset
        
        fur_alina_drums_timings.each do
          rhythm 1, fur_alina_drums_timings[tick]
        end
        
        sync :round
      end
      
    end
    
  end
  
end # define :fur_alina


#
# Main program.
#

# Start the ambient background sound before the melody.
ambient_tropical_sea

# Sleep 8 beats before playing the melody.
sleep 8

# Play the melody.
fur_alina


