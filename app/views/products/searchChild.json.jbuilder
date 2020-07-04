json.array! @children do |child|
  json.id child.id
  json.name child.name
  json.ancestry child.ancestry
end