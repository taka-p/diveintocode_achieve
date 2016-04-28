FactoryGirl.define do
  factory :task do
    user nil
    title "MyString"
    content "MyText"
    deadline "2016-04-28 11:54:58"
    charge_id 1
    done false
    status 1
  end
end
