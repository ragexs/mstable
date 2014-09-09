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
      next unless avr.mmm
      [
          link_to(avr.mmm.mdu, avrs_path(mdu: avr.mmm.mdu)), #показать все аварии по данной мдю
          link_to(avr.mmm.adress, avr), #показать данное мдю и адрес http://127.0.0.1:3000/mmms/№№№

          link_to(avr.type_avr, avr),
          ERB::Util.h(avr.material),
          ERB::Util.h(avr.comment),
          link_to(avr.user.email, avrs_path(user_id: avr.user.id)), # показать все аварии єтого юзверя
          ERB::Util.h(avr.date_on),
          ERB::Util.h(avr.date_off)
      ]
    end.compact
  end

  def avrs
    @avrs ||= fetch_avrs
  end

  def fetch_avrs
    avrs = Avr
    avrs = avrs.joins(:mmm).joins(:user)
    avrs = avrs.where(mmms: {mdu: params[:mdu]}) if params[:mdu].present?
    avrs = avrs.where(users: {id: params[:user_id]}) if params[:user_id].present?
    avrs = avrs.where(date_off: nil) unless params[:mdu].present?
    avrs = avrs.order("#{sort_column} #{sort_direction}")
    avrs = avrs.page(page).per_page(per_page)
    if params[:search][:value].present?
      avrs = avrs.joins(:mmm).where("mdu like :search or adress like :search", search: "%#{params[:search][:value]}%")
    end
    avrs
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 20
  end

  def sort_column
    columns = %w[mmms.mdu mmms.adress type_avr material comment users.email date_on date_off]
    columns[params[:order]["0"]["column"].to_i] || "date_on"
  end

  def sort_direction
    params[:order]["0"]["dir"]
  end
end