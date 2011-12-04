class StringInput < Formtastic::Inputs::StringInput
  def to_html
    input_wrapping do
      label_html <<
      template.content_tag(:div, builder.text_field(method, input_html_options), :class => 'input')
    end
  end
end