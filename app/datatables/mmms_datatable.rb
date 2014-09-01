class MmmsDatatable
  delegate :params, :h, :link_to, :number_to_currency, :new_avr_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Mmm.count,
        iTotalDisplayRecords: mmms.total_entries,
        aaData: data
    }
  end

  private

  def data
    mmms.map do |mmm|
      [
          link_to( ERB::Util.h(mmm.mdu),new_avr_path(mmm_id: mmm.id)),

          link_to(mmm.adress, mmm),
          ERB::Util.h(mmm.porch),
          ERB::Util.h(mmm.ip),
          link_to(mmm.sys_name, mmm),
          ERB::Util.h(mmm.ingress),
          ERB::Util.h(mmm.mod)
      ]
    end
  end

  def mmms
    @mmms ||= fetch_mmms
  end

  def fetch_mmms
    mmms = Mmm.order("#{sort_column} #{sort_direction}")
    mmms = mmms.page(page).per_page(per_page)
    if params[:sSearch].present?
      mmms = mmms.where("mdu like :search or adress like :search", search: "%#{params[:sSearch]}%")
    end
    mmms
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