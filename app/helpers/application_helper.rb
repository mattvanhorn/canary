module ApplicationHelper
  
  def semantic_input_tag(name, type = :string, label = nil)
    # %li#auth_key_input.string.input
    #   = label_tag :auth_key, "Login"
    #   .input= text_field_tag :auth_key

    content_tag(:li, :id => "#{name}_input", :class => ['input', type.to_s].join(' ').strip) do
      label_text = t(".#{name.to_s}")
      label_tag(name, label || label_text) + "\n" +
      content_tag(:div, :class => 'input') do
        case type
        when :password
          password_field_tag(name)
        else
          text_field_tag(name)
        end
      end
    end
  end
  
  def flash_errors
    result = ""
    [flash[:alert]].flatten.each do |msg|
      result << content_tag(:p, msg, :class => 'alert')
    end
    result.html_safe
  end
end
