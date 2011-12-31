module SimpleForm
  module Components
    # modify simple form inputs to use a markup structure similar to Twitter Bootstrap
    module ContainedInput
      def contained_input
        '<div class="input">' + input + "#{error || hint}" + '</div>'
      end
    end
  end

  module Inputs
    # uses ContainedInput to wrap inputs in Twitter Bootstrap divs
    class Base
      include SimpleForm::Components::ContainedInput
    end
  end
end