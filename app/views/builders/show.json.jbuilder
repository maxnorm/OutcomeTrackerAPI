json.(@canadian_builder, :id, :name, :title, :location, :category, :description, :achievement, :avatar, :website, :slug)

json.government do
  json.(@canadian_builder.government, :id, :name)
end