module Api
  module Constants
    class CsgoMapsController < BaseController
      WEB_MAP_IMAGE = {
        'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_inferno.jpg',
        'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_mirage.jpg',
        'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_overpass.jpg',
        'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_cache.jpg',
        'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_train.jpg',
        'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_cobblestone.jpg',
        'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_nuke.jpg',
        'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/web_dust2.jpg',
        'Vertigo': 'https://onehole-assets.oss-cn-hangzhou.aliyuncs.com/csgo/vertigo.jpg'
      }

      WEB_BG_MAP_IMAGE = {
        'Inferno': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_inferno.jpg',
        'Mirage': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_mirage.jpg',
        'Overpass': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_overpass.jpg',
        'Cache': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_cache.jpg',
        'Train': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_train.jpg',
        'Cobblestone': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_cobblestone.jpg',
        'Nuke': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_nuke.jpg',
        'Dust2': 'http://risewinter-assets.oss-ap-southeast-1.aliyuncs.com/map/web/bg_dust2.jpg',
        'Vertigo': 'https://onehole-assets.oss-cn-hangzhou.aliyuncs.com/csgo/de_vertigo.jpg'
      }

      def index
          render json: {
            data: {
              backgrounds: WEB_BG_MAP_IMAGE,
              maps: WEB_MAP_IMAGE
            }
          }
      end
    end
  end
end
