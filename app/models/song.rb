class Song < ActiveRecord::Base
	extend FriendlyId
      friendly_id :title, use: :slugged
  
  include Publishable
  include Purchasable

   enum category:
  	{
      background_music: 0,
      general: 1,
      outtro_tune: 2,
      score: 3,
      short_riff: 4,
      theme_song: 5,
      transition_tune: 6
  	}
  
  enum mood:
  	{	
      anger_or_angst: 0,
      calm_and_peaceful: 1,
      eerie_or_horrific: 2,
      emotional_or_sad: 3,
      energetic_and_lively: 4,
      groove_and_funk: 5,
      happy_and_positive: 6,
      horrific_or_suspenseful: 7,
      hot_and_sexy: 8,
      light_and_fun: 9,
      noisy_and_jarring: 10,
      powerful_or_poignant: 11,
      romantic_or_passionate: 12
  	}
  
  enum genre:
  	{
      acid: 0, 
      blues: 1, 
      classic_rock: 2, 
      classical: 3, 
      comedic: 4, 
      disco: 5, 
      drum_and_bass: 6, 
      dubstep: 7, 
      easy_listening: 8, 
      electronica: 9, 
      experimental: 10, 
      folk: 11, 
      funk: 12, 
      gangsta_rap: 13, 
      glitch: 14, 
      gospel: 15, 
      hard_rock: 16, 
      hardcore: 17, 
      heavy_metal: 18, 
      hip_hop: 19, 
      holiday: 20, 
      house: 21, 
      indie_pop: 22, 
      industrial: 23, 
      jazz: 24, 
      jungle: 25, 
      latin: 26, 
      new_age: 27, 
      oldskool_rap: 28, 
      operatic: 29, 
      pop: 30, 
      reggae: 31, 
      relaxation: 32, 
      retro_8_bit_or_chip: 33, 
      soft_rock: 34, 
      soul_and_rnb: 35, 
      spiritual: 36, 
      techno: 37, 
      trance: 38, 
      vocal: 39
      }
  
  self.per_page = 8
end
