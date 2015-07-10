module ApplicationHelper
	def fix_url(str)
		str.starts_with?('http://') ? str : "http://#{str}"
	end

	def display_datetime(dt)
		dt = dt.in_time_zone(current_user.time_zone) if logged_in? && !current_user.time_zone.blank?
		dt.strftime("%Y/%m/%d %l:%M%P %Z") # 03/17/2015 9:09 pm
	end
end
