json.array!(@mmms) do |mmm|
  json.extract! mmm, :id, :mdu, :adress, :porch, :ip, :sys_name, :ingress, :mod
  json.url mmm_url(mmm, format: :json)
end
