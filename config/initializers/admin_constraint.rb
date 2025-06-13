class AdminConstraint
  def self.matches?(request)
    request.env["HTTP_AUTHORIZATION"] == "Basic " + Base64.strict_encode64("#{ENV['ADMIN_LOGIN']}:#{ENV['ADMIN_PASSWORD']}")
  end
end
