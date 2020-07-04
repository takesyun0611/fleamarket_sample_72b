metal, jazz = Category.create([{name: "metal"}, {name: "jazz"}])

melodic, black = metal.children.create([{name: "melodic"}, {name: "black"}])
melodic.children.create([{name: "melodic-death"}, {name: "melodic-speed"}])
black.children.create([{name: "symphonic-black"}, {name: "melodic-black"}])

swing, modern = jazz.children.create([{name: "swing"}, {name: "modern"}])