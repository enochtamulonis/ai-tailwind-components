module DashboardHelper
  def omniauth_name(name)
    case name
    when "GoogleOauth2"
      "Google"
    else
      name
    end
  end
end
