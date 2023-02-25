load("class.star",
     f_typename = "f_typename",
     f_fields = "f_fields",
     f_methods = "f_methods",
     f_parents = "f_parents",
     new_class = "new_class",
     new_object = "new_object",
)

f_fur = "fur"
m_has_fur = "has_fur"
m_has_feathers = "has_feathers"
m_has_tail = "has_tail"
tpn_mammal = "mammal"

def mammal_has_fur(myself):
    return myself[f_fields][f_fur]

def mammal_has_feathers(myself):
    return "nope"

def mammal_has_tail(myself):
    return "maybe"

def cat_has_tail(myself):
    base_class = myself[f_parents][tpn_mammal]
    parent_has_tail = base_class[f_methods][m_has_tail](myself)
    return parent_has_tail + " but yes"

mammal_t = new_class(
    typename = tpn_mammal,
    fields = {
        f_fur: "lots",
    },
    methods = {
        m_has_fur: mammal_has_fur,
        m_has_tail: mammal_has_tail,
        m_has_feathers: mammal_has_feathers,
    },
)

cat_t = new_class(
    typename = "cat",
    fields = {
        f_fur: "definitely",
    },
    methods = {
        m_has_fur: mammal_has_fur,
        m_has_tail: cat_has_tail,
    },
    parents = [mammal_t],
)

my_mammal = new_object(mammal_t)

my_cat = new_object(cat_t)

print("mammal: has fur: " + my_mammal[f_methods][m_has_fur](my_mammal))

print("mammal: has fur: " + my_mammal[f_methods][m_has_fur](my_mammal))
print("mammal: has feathers: " + my_mammal[f_methods][m_has_feathers](my_mammal))
print("mammal: has tail: " + my_mammal[f_methods][m_has_tail](my_mammal))

print("cat: has fur: " + my_cat[f_methods][m_has_fur](my_cat))
print("cat: has feathers: " + my_cat[f_methods][m_has_feathers](my_cat))
print("cat: has tail: " + my_cat[f_methods][m_has_tail](my_cat))
