json.array!(@summits) do |summit|
  json.extract! summit, :id, :name, :deadline, :location_city, :location_country, :language, :date_start, :date_end, :cost, :currency, :fields, :idea_stage, :planning_stage, :implementation_stage, :operating_stage, :contact_website, :contact_email, :admin_email, :admin_url
  json.url summit_url(summit, format: :json)
end
