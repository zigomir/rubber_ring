FactoryGirl.define do

  factory :page, class: RubberRing::Page do
    controller 'test'
    action 'test'
    content({'key' => 'value'})
  end

end
