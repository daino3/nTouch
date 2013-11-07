FactoryGirl.define do
  
  factory :user do
    first_name "Alexander"
    last_name "Larson"
    email "alexisboss@heckyes.biz"
    birthday "July 31, 1984"
    phone_number "1234567890"

  end

  factory :invalid_user do
    first_name "O'Doyle"
    last_name "Rules!"
    email nil
    birthday "July 31, 1984"
    phone_number "1234567890"
  end

  factory :friend do
    first_name "Fred"
    last_name "Bob"
    email "fred@bob.com"
    birthday "October 25, 1987"
    phone_number "1234567890"
  end

  factory :invalid_friend do
    first_name "Fred"
    last_name "Bob"
    email nil
    birthday "October 25, 1987"
    phone_number "1234567890"
  end
end