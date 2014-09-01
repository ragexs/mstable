class AvrsDatatable
  delegate :params, :h, :link_to, :number_to_currency, :avrs_path,  to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Avr.count,
        iTotalDisplayRecords: avrs.total_entries,
        aaData: data
    }
  end

  private

  def data
    avrs.map do |avr|
      [
          link_to(avr.mmm.mdu, avrs_path(mdu: avr.mmm.mdu)), #показать все аварии по данной мдю
          link_to(avr.mmm.adress, avr), #показать данное мдю и адрес http://127.0.0.1:3000/mmms/№№№

          link_to(avr.type_avr, avr),
          ERB::Util.h(avr.material),
          ERB::Util.h(avr.comment),
          link_to(avr.user.email, avr), # показать все аварии єтого юзверя
          ERB::Util.h(avr.date_on),
          ERB::Util.h(avr.date_off)
      ]
    end
  end

  def avrs
    @avrs ||= fetch_avrs
  end

  def fetch_avrs
    avrs = Avr#.order("#{sort_column} #{sort_direction}")
    avrs = avrs.joins(:mmm).where(mmms: {mdu: params[:mdu]}) if params[:mdu].present?
    avrs = avrs.where(date_off: nil) unless params[:mdu].present?
    avrs = avrs.page(page).per_page(per_page)
    if params[:sSearch].present?
      avrs = avrs.where("mdu like :search or adress like :search", search: "%#{params[:sSearch]}%")
    end
    avrs
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 20
  end

  def sort_column
    columns = %w[ mdu released_on adress]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end