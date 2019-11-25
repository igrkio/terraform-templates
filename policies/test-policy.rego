import "tfplan"
import "strings"

# Find all resources of specific type from all modules using the tfplan import
find_resources_from_plan = func(type) {
    resources = {}
    for tfplan.module_paths as path {
        for tfplan.module(path).resources[type] else {} as name, instances {
            for instances as index, r {
                # Get the address of the resource instance
                if length(path) == 0 {
                    # root module
                    address = type + "." + name + "[" + string(index) + "]"
                } else {
                    # non-root module
                    address = "module." + strings.join(path, ".module.") + "." +
                              type + "." + name + "[" + string(index) + "]"
                }
                # Add the instance to resources, setting the key to the address
                resources[address] = r
            }
        }
    }
    return resources
}
