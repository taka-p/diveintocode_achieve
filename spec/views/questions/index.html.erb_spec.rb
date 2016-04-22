require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :user => nil,
        :category => nil,
        :language => nil,
        :title => "Title",
        :content => "Content"
      ),
      Question.create!(
        :user => nil,
        :category => nil,
        :language => nil,
        :title => "Title",
        :content => "Content"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
