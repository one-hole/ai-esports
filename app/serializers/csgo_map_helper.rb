module CsgoMapHelper
  APP_MAP_IMAGE = {
      'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_inferno.jpg',
      'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_mirage.jpg',
      'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_overpass.jpg',
      'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_cache.jpg',
      'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_train.jpg',
      'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_cobblestone.jpg',
      'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_nuke.jpg',
      'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_dust2.jpg'
  }

  APP_FORBIDDEN_MAP_IMAGE = {
      'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_inferno_forbidden.jpg',
      'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_mirage_forbidden.jpg',
      'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_overpass_forbidden.jpg',
      'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_cache_forbidden.jpg',
      'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_train_forbidden.jpg',
      'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_cobblestone_forbidden.jpg',
      'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_nuke_forbidden.jpg',
      'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/app_dust2_forbidden.jpg'
  }

  APP_BG_MAP_IMAGE = {
      'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_inferno.jpg',
      'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_mirage.jpg',
      'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_overpass.jpg',
      'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_cache.jpg',
      'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_train.jpg',
      'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_cobblestone.jpg',
      'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_nuke.jpg',
      'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/app/bg_dust2.jpg'
  }

  WEB_MAP_IMAGE = {
      'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_inferno.jpg',
      'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_mirage.jpg',
      'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_overpass.jpg',
      'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_cache.jpg',
      'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_train.jpg',
      'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_cobblestone.jpg',
      'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_nuke.jpg',
      'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_dust2.jpg'
  }

  WEB_BG_MAP_IMAGE = {
      'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_inferno.jpg',
      'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_mirage.jpg',
      'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_overpass.jpg',
      'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_cache.jpg',
      'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_train.jpg',
      'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_cobblestone.jpg',
      'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_nuke.jpg',
      'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_dust2.jpg'
  }

  def get_app_map_image(map)
    return nil if map.nil? || map.empty?
    eval("APP_MAP_IMAGE[:#{map}]")
  end

  def get_app_forbidden_map_image(map)
    return nil if map.nil? || map.empty?
    eval("APP_FORBIDDEN_MAP_IMAGE[:#{map}]")
  end

  def get_app_bg_map_image(map)
    return nil if map.nil? || map.empty?
    eval("APP_BG_MAP_IMAGE[:#{map}]")
  end

  def get_web_map_image(map)
    return nil if map.nil? || map.empty?
    eval("WEB_MAP_IMAGE[:#{map}]")
  end

  def get_web_bg_map_image(map)
    return nil if map.nil? || map.empty?
    eval("WEB_BG_MAP_IMAGE[:#{map}]")
  end
end
