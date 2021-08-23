FactoryBot.define do
  factory :user do
    name { "name001" }
    password { "password" }
    # password_confirmation { "password" }
    admin { true }
    baby_due_on { "2021-12-01" }
  end

  factory :second_user, class: User do
    name { "name002" }
    password { "password" }
    # password_confirmation { "password" }
    admin { true }
    baby_due_on { "2021-12-01" }
  end

  factory :third_user, class: User do
    name { "name003" }
    password { "password" }
    # password_confirmation { "password" }
    admin { false }
    baby_due_on { "2021-12-01" }
  end
end
