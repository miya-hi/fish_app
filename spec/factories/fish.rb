FactoryBot.define do
  factory :fish do
    name { "fish001" }
    line { "あ" }
    n3_oil { 1.25 }
    vitamin_a { 100 }
    mercury { 62.5 }
    content { "1匹60g" }
    image { "fish001.png" }
  end

  factory :second_fish, class: Fish do
    name { "fish002" }
    line { "か" }
    n3_oil { 1.50 }
    vitamin_a { 500 }
    mercury { 125 }
    content { "" }
    image { "" }
  end

  factory :third_fish, class: Fish do
    name { "fish003" }
    line { "さ" }
    n3_oil { 0.65 }
    vitamin_a { 1000 }
    mercury { nil }
    content { "" }
    image { "" }
  end
end
