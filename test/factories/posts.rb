FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { 
      r = rand(0..1)
      if r == 0
        false
      else
        true
      end
     }
    #Factory bot se da cuenta de la relacion con el factory user, no es necesario refe-
    #renciarlo
    user 
  end
end
