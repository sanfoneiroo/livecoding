## BUFFER1 - ENGINE CONTROL ##

#=begin DESCOMENTE PARA CONTROLE POR INTERFACE MIDI
set :groove_mode, 0
set :melody_mode, 0
set :bass_mode, 0
set :bpm, 90
#=end

set :controller_mode, 0

set :fx_cutoff, 90

set :bpm_min, 60
set :bpm_max, 140

set :sample_event, nil
set :sample_fx, 0.5


live_loop :engine do
  
  use_bpm (get(:bpm) || 90)
  
  steps = get(:steps) || 16
  step_time = get(:step_time) || 0.25
  
  i = tick % steps
  
  ## GROOVE
  
  kick_bank  = get(:kick_bank)
  snare_bank = get(:snare_bank)
  hihat_bank = get(:hihat_bank)
  
  groove_mode = get(:groove_mode) || 0
  
  groove = groove_mode % kick_bank.length
  
  kick  = kick_bank[groove]
  snare = snare_bank[groove]
  hihat = hihat_bank[groove]
  
  sample :bd_haus if kick[i] == 1
  sample :sn_dolf if snare[i] == 1
  sample :drum_cymbal_closed if hihat[i] == 1
  
  
  ## MELODY
  
  melody_bank = get(:melody_bank) || [[nil]*16]
  melody_mode = (get(:melody_mode) || 0) % melody_bank.length
  
  melody = melody_bank[melody_mode]
  
  note = melody[i]
  play note if note
  
  
  ## BASS
  
  bass_bank = get(:bass_bank) || [[nil]*16]
  bass_mode = (get(:bass_mode) || 0) % bass_bank.length
  
  bass = bass_bank[bass_mode]
  
  note = bass[i]
  play note, release: 0.4 if note
  
  
  ## SAMPLE EVENT ENGINE
  
  event = get(:sample_event)
  fx = get(:sample_fx) || 0.5
  
  case event
  
  when :impact
    
    with_fx :reverb, mix: fx, room: 0.8 do
      with_fx :echo, mix: fx * 0.6, phase: 0.25 do
        
        rate = -0.5 - (fx * 0.5)
        
        sample :ambi_glass_rub,
          rate: rate,
          attack: 0.1,
          release: 2,
          amp: 1.2
        
      end
    end
    
  when :reverse
    
    with_fx :reverb, mix: fx * 0.5 do
      with_fx :echo, mix: fx, phase: 0.25 do
        
        sample :elec_blip2,
          rate: -1,
          release: 0.3,
          amp: 1
        
      end
      
      set :sample_event, nil if event
    end
    
  when :noise
    
    with_fx :reverb, mix: fx * 0.6, room: 0.9 do
      with_fx :lpf, cutoff: 60 + (fx * 60) do
        
        sample :ambi_soft_buzz,
          attack: 0.05,
          release: 1.5 + fx,
          amp: 1.2
        
      end
    end
    
  end
  
  sleep step_time
  
end