json.fishes do
  json.array! @fishes, :id, :name, :line, :n3_oil, :n3_oil_no_data, :vitamin_a, :vitamin_a_tr, :vitamin_a_no_data, :mercury, :content, :image
end
