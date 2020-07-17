module Panda
  class FetchLeague
    def self.run
      fetch_dota_league
      fetch_lol_league
    end

    def self.fetch_dota_league
      (1..3).each do |page|
        resp = Request.get('https://api.pandascore.co/dota2/leagues', page)
        handler_league(resp, 1)
      end
    end

    def self.fetch_lol_league
      (1..2).each do |page|
        resp = Request.get('https://api.pandascore.co/lol/leagues', page)
        handler_league(resp, 2)
      end
    end

    def self.handler_league(resp, game_id)
      JSON.parse(resp).each do |panda_league|
        league = Embrace::League.find_by(third_id: panda_league['id'])

        league ||= Embrace::League.create(
          game_id: game_id,
          third_id: panda_league['id'],
          name: panda_league['name'],
          abbr: panda_league['slug'],
          image: panda_league['image_url']
          )

        panda_league['series'].each do |single_series|
          handler_series(single_series, league)
        end
      end
    end

    def self.handler_series(single_series, league)
      series = Embrace::Series.find_by(third_id: single_series['id'])

      if series
        series.update(
          third_id: single_series['id'],
          game_id: league.game_id,
          league_id: league.id,
          name: single_series['name'],
          season: single_series['season'],
          year: single_series['year'],
          begin_at: single_series['begin_at'],
          end_at: single_series['end_at']
        )
      else
        Embrace::Series.create(
          third_id: single_series['id'],
          game_id: league.game_id,
          league_id: league.id,
          name: single_series['name'],
          season: single_series['season'],
          year: single_series['year'],
          begin_at: single_series['begin_at'],
          end_at: single_series['end_at']
        )
      end
    end
  end
end

# PerPage 50
# DotA 3 页 5
# LOL  2 页 13