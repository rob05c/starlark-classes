
# these are the names of fields uses by classes.
# becuase standard Skylark only gives us a dict to work with,
# we have string keys.
f_typename = "typename"
f_fields = "fields"
f_methods = "methods"
f_parents = "parents"
f_super = "super"

def new_class(
    typename,
    fields = {},
    methods = {},
    parents = [],
):
    """Create and return a new class.

    Keyword arguments:

    typename -- the type name of the class

    fields -- the data field members of the class, instantiated to any defaults

    methods -- the methods of the class.
               Methods should always take _self_ as the first parameter,
               which allows them to access fields, other methods, and call
               self[f_super]() to get the base class.

    parent_classes -- the base classes, if any. Base class members will
                      be applied to the returned class, in order, only
                      if they don't exist (standard inheritance).
                      If there are multiple parents, they are applied left-to-right
    """
    cl = {}
    cl[f_typename] = typename
    cl[f_fields] = fields
    cl[f_methods] = methods
    cl[f_parents] = {}

    for parent in parents:
        for parent_field_name, parent_field_default_value in parent[f_fields].items():
            if parent_field_name in cl[f_fields]:
                continue
            cl[f_fields][parent_field_name] = parent_field_default_value
        for parent_method_name, parent_method in parent[f_methods].items():
            if parent_method_name in cl[f_methods]:
                continue
            cl[f_methods][parent_method_name] = parent_method
            cl[f_parents][parent[f_typename]] = parent

    return cl

def new_object(clas):
    """Takes a class created from new_class, and returns an object from it.

    """
    obj = {
        f_typename: clas[f_typename],
        f_fields: clas[f_fields],
        f_methods: clas[f_methods],
        f_parents: clas[f_parents],
    }

    return obj
