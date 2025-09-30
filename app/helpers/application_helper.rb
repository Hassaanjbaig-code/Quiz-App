module ApplicationHelper
  def tailwind_alert(message, type = "notice")
    colors = {
      "notice"  => "bg-green-100 text-green-800 border-green-300",
      "success" => "bg-green-100 text-green-800 border-green-300",
      "error"   => "bg-red-100 text-red-800 border-red-300",
      "alert"   => "bg-yellow-100 text-yellow-800 border-yellow-300"
    }

    content_tag(:div, message,
      class: "border-l-4 p-4 rounded #{colors[type] || colors['notice']}")
  end
end
