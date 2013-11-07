FactoryGirl.define do
  
  factory :user do
    first_name "Alexander"
    last_name "Larson"
    email "alexisboss@heckyes.biz"
    birthday "July 31, 1984"

  end

  factory :invalid_user do
    first_name "O'Doyle"
    last_name "Rules!"
    email nil
    birthday "July 31, 1984"
  end

end