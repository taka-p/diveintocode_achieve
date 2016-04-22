require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :user => nil,
      :category => nil,
      :language => nil,
      :title => "MyString",
      :content => "MyString"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_user_id[name=?]", "question[user_id]"

      assert_select "input#question_category_id[name=?]", "question[category_id]"

      assert_select "input#question_language_id[name=?]", "question[language_id]"

      assert_select "input#question_title[name=?]", "question[title]"

      assert_select "input#question_content[name=?]", "question[content]"
    end
  end
end
