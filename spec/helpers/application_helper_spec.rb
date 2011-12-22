require 'spec_helper'

describe ApplicationHelper do

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

