FactoryBot.define do
  factory :diary do
    input_at { "2021-08-15" }
    user_id { 1 }
    fish_id { 1 }
    amount { 80 }
  end
  factory :second_diary, class: Diary do
    input_at { "2021-08-15" }
    user_id { 2 }
    fish_id { 2 }
    amount { 80 }
  end
  factory :third_diary, class: Diary do
    input_at { "2021-08-15" }
    user_id { 3 }
    fish_id { 3 }
    amount { 80 }
  end
end
