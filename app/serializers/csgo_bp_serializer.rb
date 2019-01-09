class CsgoBpSerializer < ActiveModel::Serializer
  include CsgoMapHelper
  attributes :csgo_bps

  def csgo_bps
    return {} if object.blank?
    return Array.new if object.bp_info.blank?
    bp = JSON.parse(object.bp_info)
    left_team = object.left_team.name
    right_team = object.right_team.name

    bp.map  do |m|
      m.merge({
      map_img: m['map'].nil? ? nil : get_web_map_image(m['map']),
      team: {
        name: m['side'] === 'left' ? left_team : right_team
        }
      })
    end
  end
end
