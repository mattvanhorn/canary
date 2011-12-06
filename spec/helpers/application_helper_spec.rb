require 'spec_helper'

describe ApplicationHelper do
  describe "#semantic_input_tag" do
    it "wraps a text input tag like Formtastic" do
      expected = <<-HTML
<li class="input string" id="my_field_input"><label for="my_field">my label</label>
<div class="input"><input id="my_field" name="my_field" type="text" /></div></li>
HTML
      helper.semantic_input_tag(:my_field, :string, "my label").should == expected.strip
    end
    it "wraps a password input tag like Formtastic" do
      helper.should_receive(:t).with('.my_field').and_return('Password')
      expected = <<-HTML
<li class="input password" id="my_field_input"><label for="my_field">Password</label>
<div class="input"><input id="my_field" name="my_field" type="password" /></div></li>
HTML
      helper.semantic_input_tag(:my_field, :password).should == expected.strip
    end
  end
  
  describe "#flash_errors" do
    it "outputs multiline errors" do
      flash[:alert] = ['foo','bar']
      expected = <<-HTML
<div class="alert-message block-message error" data-alert="alert"><a href="#" class="close">x</a><ul><li>foo</li>
<li>bar</li></ul></div>
      HTML
      helper.flash_errors.should == expected.strip
    end
    it "outputs single line errors" do
      flash[:alert] = ['foo']
      helper.flash_errors.should == '<div class="alert-message error">foo</div>'
    end
  end
end

