require 'mustache'

module App
  module View
    module TemplateEngine
      class MustacheTemplateEngine
        def initialize(config)
          Mustache.template_path = config[:template_path]
        end

        def render(template_name, view_model)
          Mustache.template_name = template_name
          Mustache.render(Mustache.template, view_model)
        end
      end
    end
  end
end
