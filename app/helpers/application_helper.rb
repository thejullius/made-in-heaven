module ApplicationHelper
  def sort_link(title, field)
    order_param = params.fetch(:order_direction, :desc)
    order_direction = order_param === 'desc' ? :asc : :desc

    if params.dig(:order_column) == field.to_s
      caret_direction = order_direction == :asc ? 'down' : 'up'
      title = "#{title} #{content_tag(:i, '', class: "fa fa-caret-#{caret_direction}")}"
    end

    link_to title.html_safe, params.permit!.merge(order_direction: order_direction, order_column: field)
  end
end
