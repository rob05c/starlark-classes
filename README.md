# Starlark Classes

Proof-of-concept implementation of classes in Starlark.

Starlark doesn't provide any form of polymorphism. It's generally better to favor composition over inheritance, but sometimes inheritance is the right tool for the job. Sometimes your config is complex enough, it becomes overly duplicate and messy without better structure.

## Implementation

There are several ways polymorphism could be implemented in Starlark.

You could use lambdas and closures. But the interfaces created by that are a bit awkward, especially for users unfamiliar with Functional Programming.

You could also use structs. But structs are an extension to Starlark, not part of the base language, and may not be available to some users.

You could use a DSL to make the syntax anything you like, with an additional compile step to generate Starlark code. But that's an entirely different solution, with entirely different advantages and disadvantages, than a library.

You could use a combination of `dict` and first-class functions. Which is less powerful and has a bit more boilerplate than some alternatives, but provides a simpler interface and implementation.

This library implements the last option.

## Usage

Create types with `new_class`:

```python
f_fur = "fur"
m_has_fur = "has_fur"
m_has_feathers = "has_feathers"
m_has_tail = "has_tail"
tpn_birb = "birb"

birb_t = new_class(
    typename = tpn_birb,
    fields = {
        f_fur: "nope",
    },
    methods = {
        m_has_fur: lambda myself : myself[f_fields][f_fur],
        m_has_feathers: lambda myself : "absolutely",
    },
)
```

Then create an object from the type:

```python
my_birb = new_object(birb_t)
my_birb[f_fields][f_fur] = "none at all"

print("birb has fur: " + my_birb[f_methods][m_has_fur](my_birb))
print("birb has feathers: " + my_birb[f_methods][m_has_feathers](my_birb))
```

Which prints:

```sh
birb has fur: none at all
birb has feathers: absolutely
```

See `examples.star` for more complex examples of polymorphism, inheriting, accessing base class members from subclasses, and overriding inherited fields and methods.

### Frequently Asked Questions

*Why?*

Because sometimes polymorphism is more readable than the alternative.

*This is pretty simple, kind of ugly, and not very elegant or expressive.*

Was there a question?

Starlark doesn't give us much to work with. This is only about 50 lines of code. With the built-in types, more code isn't really going to make this more expressive.

Without a custom DSL and an extra compile step, we can't really add syntactic sugar to make it prettier.

You could make the polymorphism a little smarter, but that's about it.

*Should I use this?*

Probably not.
