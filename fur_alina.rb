use_debug false
set_volume! 0.5

base_bpm = 90
use_bpm base_bpm

home_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
samps_dir = home_dir + "samps/"

celesta_samp = vpo_dir + "celesta-e5-hard-PB.wav"
celesta_note = ":E5"

cello_samp = vpo_dir + "cello-e5-stac-rr1-PB.wav"
cello_note = ":E5"

halftone = Math.log(2.0) / 12.0
octtone = Math.log(2.0)
centtone = halftone / 100.0
tempo = 1.0

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
  
  samps_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/samps/"
  
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
  
  # total 107 beats
  fur_alina_timings = [
    4,
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
  
  in_thread(name: :melody) do
    
    shift_melody_right = 0
    shift_melody_left = 0
    new_bpm = 60
    
    in_thread(name: :bass) do
      loop do
        sync :round
        with_synth :piano do
          with_fx :reverb, mix: 1.0, room: 1 do
            play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1
          end
        end
      end
      
    end
    
    in_thread(name: :right) do
      loop do
        cue :round
        use_bpm new_bpm
        with_fx :reverb, mix: 1, room: 0.5, amp: 2.0 do
          tick_reset
          fur_alina_right_hand.each do
            tick
            playwavnote celesta_samp, celesta_note, fur_alina_right_hand[look] + shift_melody_right, fur_alina_timings[look]
          end
        end
        shift_melody_right = choose([-12, 0, 12])
        new_bpm = base_bpm + choose([-10, -5, 0, 10, 20])
      end
    end
    
    in_thread(name: :left) do
      loop do
        sync :round
        use_bpm new_bpm
        with_fx :reverb, mix: 1, room: 0.5, amp: 2.0 do
          tick_reset
          fur_alina_left_hand.each do
            tick
            playwavnote celesta_samp, celesta_note, fur_alina_left_hand[look] + shift_melody_left, fur_alina_timings[look]
          end
        end
        shift_melody_left = choose([-12, 0, 12])
      end
    end
    
  end
  
end # define :fur_alina



# Main program.

ambient_tropical_sea

sleep 8

fur_alina


