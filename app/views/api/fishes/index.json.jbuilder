json.fishes do
  json.array! @fishes, :id, :name, :line, :n3_oil, :vitamin_a, :mercury, :content, :image
end
