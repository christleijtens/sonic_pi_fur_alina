use_debug false
set_volume! 4

set :home_dir, "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
set :samps_dir, get[:home_dir] + "samps/"

run_file get[:home_dir] + "clitc_sonic_pi_lib.rb"
run_file get[:home_dir] + "fur_alina_house_lib.rb"
run_file get[:home_dir] + "fur_alina_relax_lib.rb"

set :fur_alina_score, [
  [:r, :r], # bar 1
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

# total 111 beats
set :fur_alina_timings, [
  4, # 4 beats
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

set :fur_alina_drums_timings, [
  4, 5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6 # 111 beats
]

set :fur_alina_instruments, {
  
  "celesta_hard" => {
    "wav" => "celesta-e5-hard-PB.wav",
    "note" => :E5,
    "vol" => 0.4
  },
  "cello_sustain" => {
    "wav" => "cello-sustain-4_Db-PB-loop.wav",
    "note" => :Db4,
    "vol" => 0.1
  },
  "tubularbells" => {
    "wav" => "tubularbells-4_Eb_p.wav",
    "note" => :Eb4,
    "vol" => 0.4
  },
  "cello_vibrato" => {
    "wav" => "cello-vibrato-4_Bb-PB.wav",
    "note" => :Bb4,
    "vol" => 0.1
  },
  "cello_tremulo" => {
    "wav" => "cello-tremulo-4_D_t-PB-loop.wav",
    "note" => :D4,
    "vol" => 0.5
  },
  "cor_anglais" => {
    "wav" => "cor-anglais-f4-PB-loop.wav",
    "note" => :F4,
    "vol" => 0.5
  }
}

far_config = {
  
  "samps_dir" => get[:samps_dir],
  "volume" => 2.0,
  "volume_drums" => 2.0,
  "bpm" => 80,
  "delay" => 4,
  "instrument" => "celesta_hard",
  
  "background_sounds" => {
    
    "fadeout" => 2,
    "samps_dir" => get[:samps_dir],
    "sounds" => {
      
      "haunted" => {
        "samp" => :ambi_haunted_hum,
        "amp" => 0.5,
        "pan" => 0.0,
        "delay" => 0
      },
      "waves" => {
        "samp" => "gulfwaves.wav",
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 0
      },
      "tropical" => {
        "samp" => "tropical-forrest.wav",
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 0
      }
    }
  }
  
} # far_config.



fah_config = {
  
  "synth" => :hollow,
  "bpm" => 120,
  "volume" => 2,
  "volume_drums" => 4,
  "delay" => 8
}

puts ""
puts ">>> Für Alina by Arvo Pärt - Sonic Pi version by Christ Leijtens"
puts ""

fah_config["synth"] = :dark_ambience
fah_config["delay"] = 8
fur_alina_house fah_config

far_config["instrument"] = "cello_sustain"
far_config["delay"] = 4
fur_alina_relax far_config

far_config["instrument"] = "celesta_hard"
far_config["delay"] = 4
fur_alina_relax far_config

fah_config["synth"] = :hollow
fah_config["delay"] = 0
fur_alina_house fah_config

far_config["instrument"] = "cello_sustain"
far_config["delay"] = 4
fur_alina_relax far_config

far_config["instrument"] = "celesta_hard"
far_config["delay"] = 4
fur_alina_relax far_config

fah_config["synth"] = :dark_ambience
fah_config["delay"] = 0
fur_alina_house fah_config

far_config["instrument"] = "cor_anglais"
far_config["delay"] = 4
fur_alina_relax far_config

clitc_adagium

fah_config["synth"] = :hollow
fah_config["delay"] = 8
fur_alina_house fah_config

puts ""
puts "<<< Thank your for listening."
puts ""

