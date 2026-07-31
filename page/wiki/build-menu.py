import os, json

ROOT = "data"
IGNORE_DIRS = {"md-img"}  # asset-only folders, no html to show

def has_html(path):
    for dp, dns, fns in os.walk(path):
        if any(f.lower().endswith(".html") for f in fns):
            return True
    return False

def build(path):
    dirs = []
    files = []
    for name in sorted(os.listdir(path)):
        full = os.path.join(path, name)
        if os.path.isdir(full):
            if name in IGNORE_DIRS:
                continue
            if not has_html(full):
                continue
            node = {"title": name, "children": build(full)}
            dirs.append(node)
        elif name.lower().endswith(".html"):
            title = name[:-5]
            rel = os.path.relpath(full, ".").replace(os.sep, "/")
            files.append({"title": title, "src": rel})
    # dirs first, then files
    return dirs + files

tree = build(ROOT)
data = {"title": "我的 Wiki", "menu": tree}
with open("menu.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

# also emit menu.js fallback (JSON assigned to global) for file:// double-click
with open("menu.js", "w", encoding="utf-8") as f:
    f.write("window.WIKI_MENU = ")
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write(";\n")

# stats
folders = leaves = depth = 0
def count(nodes, d=0):
    global folders, leaves, depth
    for n in nodes:
        if "children" in n:
            folders += 1
            depth = max(depth, d + 1)
            count(n["children"], d + 1)
        else:
            leaves += 1
count(tree)
print("top-level categories:", len(tree))
print("folders:", folders, "leaves(html):", leaves, "max depth:", depth)
print("wrote menu.json and menu.js")
