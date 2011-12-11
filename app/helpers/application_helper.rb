module ApplicationHelper
  
  def semantic_input_tag(name, type = :string, label = nil, options ={})
    # %li#auth_key_input.string.input
    #   = label_tag :auth_key, "Login"
    #   .input= text_field_tag :auth_key
    value = options.delete(:value)
    
    content_tag(:li, :id => "#{name}_input", :class => ['input', type.to_s].join(' ').strip) do
      label_tag(name, label || t(".#{name.to_s}")) + "\n" +
      content_tag(:div, :class => 'input') do
        case type
        when :password
          password_field_tag(name, value, options)
        else
          text_field_tag(name, value, options)
        end
      end
    end
  end
  
  def flash_errors
    result = ""
    errors = [flash[:alert]].flatten
    if errors.size > 1
      result << content_tag(:div, :class => 'alert-message block-message error', :'data-alert' => 'alert') do
        link_to( "x", '#', :class => 'close') +
        content_tag(:ul) do
          errors.map{|msg| content_tag(:li, msg)}.join("\n").html_safe
        end
      end      
    elsif errors.first
      result << content_tag(:div, errors.first, :class => 'alert-message error')
    end
    result.html_safe
  end
end
