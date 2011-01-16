module Responders
  module PaginateResponder
    def initialize controller, resources, options={}
      super
      @locals = options[:locals] || {}
    end
    
    def to_js
      if get?
        controller.instance_variable_set '@resources', resource
        controller.instance_variable_set '@locals', @locals
        render :update do |page|
          page['.paginate'].replace_with render(:partial=>'page', :locals=>@locals.merge(:resources=>@resources))
        end
      else
        defined?(super) ? super : to_format
      end
    end
  end
end