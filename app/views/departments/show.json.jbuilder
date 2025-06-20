
json.(@department, :slug, :display_name, :official_name, :priority)

json.minister do
  if @department.minister.present?
    json.partial! @department.minister, as: :minister
  else
    json.null!
  end
end

json.promises do
  json.partial! "promises/promise_listing", collection: @department.lead_promises, as: :promise
end
