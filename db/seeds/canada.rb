government = Government.find_or_create_by!(name: "Government of Canada") do |g|
  g.slug = "federal"
end

government = Government.find_or_create_by!(name: "Government of Canada") { |g| g.slug = "federal" }

departments_data = [
  { slug: "agriculture-and-agri-food-canada", priority: 2, display_name: "Agriculture", official_name: "Agriculture and Agri-Food Canada" },
  { slug: "artificial-intelligence-and-digital-innovation", priority: 1, display_name: "Digital Innovation", official_name: "Artificial Intelligence and Digital Innovation" },
  { slug: "atlantic-canada-opportunities-agency", priority: 2, display_name: "ACOA", official_name: "Atlantic Canada Opportunities Agency" },
  { slug: "canada-economic-development-for-quebec-regions", priority: 2, display_name: "CED Quebec", official_name: "Canada Economic Development for Quebec Regions" },
  { slug: "canada-revenue-agency", priority: 2, display_name: "Revenue", official_name: "Canada Revenue Agency" },
  { slug: "canadian-heritage", priority: 2, display_name: "Heritage", official_name: "Canadian Heritage" },
  { slug: "crown-indigenous-relations-and-northern-affairs-canada", priority: 2, display_name: "Crown-Indigenous Relations", official_name: "Crown-Indigenous Relations and Northern Affairs Canada" },
  { slug: "emergency-preparedness-canada", priority: 2, display_name: "Emergency Preparedness", official_name: "Emergency Preparedness Canada" },
  { slug: "employment-and-social-development-canada", priority: 2, display_name: "Employment", official_name: "Employment and Social Development Canada" },
  { slug: "environment-and-climate-change-canada", priority: 2, display_name: "Environment", official_name: "Environment and Climate Change Canada" },
  { slug: "federal-economic-development-agency-for-southern-ontario", priority: 2, display_name: "FedDev Ontario", official_name: "Federal Economic Development Agency for Southern Ontario" },
  { slug: "finance-canada", priority: 1, display_name: "Finance", official_name: "Finance Canada" },
  { slug: "fisheries-and-oceans-canada", priority: 2, display_name: "Fisheries", official_name: "Fisheries and Oceans Canada" },
  { slug: "global-affairs-canada", priority: 2, display_name: "Foreign Affairs", official_name: "Global Affairs Canada" },
  { slug: "health-canada", priority: 1, display_name: "Health", official_name: "Health Canada" },
  { slug: "immigration-refugees-and-citizenship-canada", priority: 1, display_name: "Immigration", official_name: "Immigration, Refugees and Citizenship Canada" },
  { slug: "indigenous-services-canada", priority: 2, display_name: "Indigenous Services", official_name: "Indigenous Services Canada" },
  { slug: "infrastructure-canada", priority: 1, display_name: "Housing", official_name: "Infrastructure Canada" },
  { slug: "innovation-science-and-economic-development-canada", priority: 1, display_name: "Industry", official_name: "Innovation, Science and Economic Development Canada" },
  { slug: "justice-canada", priority: 2, display_name: "Justice", official_name: "Justice Canada" },
  { slug: "multiple-departments-needs-review", priority: 2, display_name: "Multiple", official_name: "Multiple Departments - Needs Review" },
  { slug: "national-defence", priority: 1, display_name: "Defence", official_name: "National Defence" },
  { slug: "natural-resources-canada", priority: 1, display_name: "Energy", official_name: "Natural Resources Canada" },
  { slug: "prime-minister-office", priority: 1, display_name: "Prime Minister", official_name: "Prime Minister's Office" },
  { slug: "privy-council-office", priority: 2, display_name: "Privy Council", official_name: "Privy Council Office" },
  { slug: "privy-council-office-intergovernmental-affairs-secretariat", priority: 2, display_name: "Privy Council / IGA", official_name: "Privy Council Office / Intergovernmental Affairs Secretariat" },
  { slug: "public-safety-canada", priority: 2, display_name: "Public Safety", official_name: "Public Safety Canada" },
  { slug: "public-services-and-procurement-canada", priority: 1, display_name: "Government Transformation", official_name: "Public Services and Procurement Canada" },
  { slug: "rural-economic-development", priority: 2, display_name: "Rural Development", official_name: "Rural Economic Development" },
  { slug: "transport-canada", priority: 1, display_name: "Internal Trade", official_name: "Transport Canada" },
  { slug: "treasury-board-of-canada-secretariat", priority: 2, display_name: "Treasury", official_name: "Treasury Board of Canada Secretariat" },
  { slug: "veterans-affairs-canada", priority: 2, display_name: "Veterans Affairs", official_name: "Veterans Affairs Canada" },
  { slug: "women-and-gender-equality-canada", priority: 2, display_name: "Gender Equality", official_name: "Women and Gender Equality Canada" }
]

departments_data.each do |attrs|
  Department.find_or_create_by!(slug: attrs[:slug], government: government) do |dept|
    dept.official_name = attrs[:official_name]
    dept.display_name = attrs[:display_name]
    dept.priority = attrs[:priority]
  end
end
