FactoryGirl.define do

  factory :page do
    controller 'test'
    action 'test'
    content({'key' => 'value'})
  end

end
