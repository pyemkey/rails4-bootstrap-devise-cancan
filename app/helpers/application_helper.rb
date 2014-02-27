module ApplicationHelper
	def display_base_errors resource
		return '' if(resource.errors.empty?) or (resource.errors[:base].empty?)
		messages = resource.errors[:base].map {|msg| content_tah(:p, msg)}.join
		html = <<-HTML
		%div{class: "alert alert-error alert-block"}
			%button.close{type: "button" "data-dismiss": "alert"} x
			#{messages}
		HTML
		html.html_safe
	end
end
