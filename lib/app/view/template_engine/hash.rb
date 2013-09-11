module App
  module View
    module TemplateEngine
      class Hash
        def render(template, view_model)
          {
            :template => template,
            :view_model => view_model,
          }
        end
      end
    end
  end
end
