module ApplicationHelper
  
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
