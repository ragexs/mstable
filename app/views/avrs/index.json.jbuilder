json.array!(@avrs) do |avr|
  json.extract! avr, :id, :mmm_id, :type_avr, :material, :comment, :user_id, :date_on, :date_off
  json.url avr_url(avr, format: :json)
end
