module ActiveAdmin
  class Config
    # Returns a properly formatted controller name for this
    # config within its namespace
    def controller_name
      [namespace.module_name, camelized_resource_name + "Controller"].compact.join('::')
    end

    # Returns the controller for this config
    def controller
      @controller ||= controller_name.constantize
    end

    # Returns the routes prefix for this config
    def route_prefix
      namespace.module_name.try(:underscore)
    end

    # Returns a symbol for the route to use to get to the
    # collection of this resource
    def route_collection_path
      route = [route_prefix, controller.resources_configuration[:self][:route_collection_name]]

      if controller.resources_configuration[:self][:route_collection_name] ==
          controller.resources_configuration[:self][:route_instance_name]
        route << "index"
      end

      route << 'path'
      route.compact.join('_').to_sym
    end

  end
end