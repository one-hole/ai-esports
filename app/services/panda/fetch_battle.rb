module Panda
  class FetchBattle
    def self.run(date = Date.today)
      yesterday = date.yesterday
      fetch_dota_battle(yesterday)
      # fetch_lol_battle(yesterday)
      # fetch_csgo_battle(yesterday)
    end

    def self.fetch_battles(date, url, game_id, page)
      date_beginning = date.beginning_of_day.iso8601
      puts date_beginning
      date = date + 3.days
      date_end = date.end_of_day.iso8601
      puts date_end
      resp = Request.get(url, page, 100, { "range[begin_at]" => "#{date_beginning},#{date_end}" })
      if resp.code == 200
        handler_battles(resp, game_id)
        if JSON.parse(resp.body).count == 100
          puts '-------------------------'
          resp = Request.get(url, page + 1, 100, { "range[begin_at]" => "#{date_beginning},#{date_end}" })
          handler_battles(resp, game_id) if resp.code == 200
        end
      end
    end

    # 暂时约定抓取 昨天（时长 6 天以内的比赛）（记录 TDB 的比赛）
    # 步长暂定为 4 天
    # 如果存在数量大于 100 的天数 那么就调用分页
    def self.fetch_dota_battle(date)
      url = 'https://api.pandascore.co/dota2/matches'
      game_id = 1
      page = 1
      fetch_battles(date, url, game_id, page)
      fetch_battles((date + 4.days), url, game_id, page)
    end

    def self.fetch_lol_battle(date)
      url = 'https://api.pandascore.co/lol/matches'
      game_id = 2
      page = 1
      fetch_battles(date, url, game_id, page)
      fetch_battles((date + 4.days), url, game_id, page)
    end

    def self.fetch_csgo_battle(date)
      url = 'https://api.pandascore.co/csgo/matches'
      game_id = 3
      page = 1
      fetch_battles(date, url, game_id, page)
      fetch_battles((date + 4.days), url, game_id, page)
    end

    private

    def self.handler_battles(resp, game_id)
      # JSON.parse(resp.body).each do |panda_battle|
      #   handler_battle(panda_battle, game_id)
      # end
    end

    # Battle belongs_to tournament
    # Tournament belongs_to Series
    # 1. 如果有 Battle 那么更新 Battle
    # 2. 如果没有 Battle
    # 2.1 获取 Tournament
    def self.handler_battle(panda_battle, game_id)
      battle = Embrace::Battle.find_by(third_id: panda_battle['id'])
      tournament = obtain_tournament(panda_battle, game_id)
    end

    #   "tournament": {
    #     "begin_at": "2020-08-02T03:00:00Z",
    #     "end_at": null,
    #     "id": 4447,
    #     "league_id": 4436,
    #     "live_supported": false,
    #     "modified_at": "2020-07-15T13:31:38Z",
    #     "name": "Group b",
    #     "prizepool": null,
    #     "serie_id": 2838,
    #     "slug": "dota-2-moon-studio-asian-league-1-2020-group-b",
    #     "winner_id": null,
    #     "winner_type": "Team"
    #   }
    #
    # 1.  如果有 Tournament 返回
    # 2.  如果没有 Tournament
    # 2.1 找到 Series ｜ 创建 Tournament
    def self.obtain_tournament(panda_battle, game_id)
      @tournament = Embrace::Tournament.find_by(third_id: panda_battle['tournament_id'])
      panda_tournament = panda_battle['tournament']
      series = obtain_series(panda_battle, game_id)
      if @tournament
        @tournament.update(
          game_id: game_id,
          begin_at: panda_tournament['begin_at'],
          end_at: panda_tournament['end_at']
        )
      else
        @tournament = Embrace::Tournament.create(
          third_id: panda_tournament['id'],
          game_id: game_id,
          league_id: series.league_id,
          series_id: series.id,
          name: panda_tournament['name'],
          begin_at: panda_tournament['begin_at'],
          end_at: panda_tournament['end_at']
        )
      end
      @tournament
    end

    #   "serie": {
    #     "begin_at": "2020-07-29T03:00:00Z",
    #     "description": null,
    #     "end_at": null,
    #     "full_name": "Season 1 2020",
    #     "id": 2838,
    #     "league_id": 4436,
    #     "modified_at": "2020-07-15T13:33:26Z",
    #     "name": null,
    #     "season": "1",
    #     "slug": "dota-2-moon-studio-asian-league-1-2020",
    #     "tier": "b",
    #     "winner_id": null,
    #     "winner_type": null,
    #     "year": 2020
    #   },
    def self.obtain_series(panda_battle, game_id)
      @series = Embrace::Series.find_by(third_id: panda_battle['serie_id'])
      single_series = panda_battle['serie']

      if @series
        @series.update(
          third_id: single_series['id'],
          game_id: game_id,
          name: single_series['name'],
          season: single_series['season'],
          year: single_series['year'],
          begin_at: single_series['begin_at'],
          end_at: single_series['end_at'],
          full_name: single_series['full_name']
        )
      else
        @series = Embrace::Series.create(
          third_id: single_series['id'],
          game_id: game_id,
          league_id: Embrace::League.find_by(third_id: single_series['league_id']).id,
          name: single_series['name'],
          season: single_series['season'],
          year: single_series['year'],
          begin_at: single_series['begin_at'],
          end_at: single_series['end_at'],
          full_name: single_series['full_name']
        )
      end
      @series
    end
  end
end

# {
#   "modified_at": "2020-07-15T13:33:18Z",
#   "slug": "2020-08-05-154e98ba-1ec0-41cc-8813-68a3c6876360",
#   "official_stream_url": null,
#   "tournament_id": 4447,
#   "opponents": [],
#   "live": {
#     "opens_at": null,
#     "supported": false,
#     "url": null
#   },
#   "status": "not_started",
#   "number_of_games": 2,
#   "league_id": 4436,
#   "league": {
#     "id": 4436,
#     "image_url": "https://cdn.pandascore.co/images/league/image/4436/Moon_Studio_Asian_League.png",
#     "modified_at": "2020-07-05T10:04:36Z",
#     "name": "Moon Studio Asian League",
#     "slug": "dota-2-moon-studio-asian-league",
#     "url": null
#   },
#   "game_advantage": null,
#   "forfeit": false,
#   "draw": false,
#   "serie": {
#     "begin_at": "2020-07-29T03:00:00Z",
#     "description": null,
#     "end_at": null,
#     "full_name": "Season 1 2020",
#     "id": 2838,
#     "league_id": 4436,
#     "modified_at": "2020-07-15T13:33:26Z",
#     "name": null,
#     "season": "1",
#     "slug": "dota-2-moon-studio-asian-league-1-2020",
#     "tier": "b",
#     "winner_id": null,
#     "winner_type": null,
#     "year": 2020
#   },
#   "live_url": null,
#   "winner": null,
#   "winner_id": null,
#   "name": ": TBD vs TBD",
#   "begin_at": "2020-08-05T07:30:00Z",
#   "streams": {
#     "english": {
#       "embed_url": null,
#       "raw_url": null
#     },
#     "russian": {
#       "embed_url": null,
#       "raw_url": null
#     }
#   },
#   "live_embed_url": null,
#   "original_scheduled_at": "2020-08-05T07:30:00Z",
#   "results": [],
#   "videogame": {
#     "id": 4,
#     "name": "Dota 2",
#     "slug": "dota-2"
#   },
#   "rescheduled": false,
#   "serie_id": 2838,
#   "match_type": "best_of",
#   "detailed_stats": true,
#   "id": 566065,
#   "games": [
#     {
#       "begin_at": null,
#       "detailed_stats": true,
#       "end_at": null,
#       "finished": false,
#       "forfeit": false,
#       "id": 664962,
#       "length": null,
#       "match_id": 566065,
#       "position": 1,
#       "status": "not_started",
#       "video_url": null,
#       "winner": {
#         "id": null,
#         "type": null
#       },
#       "winner_type": null
#     },
#     {
#       "begin_at": null,
#       "detailed_stats": true,
#       "end_at": null,
#       "finished": false,
#       "forfeit": false,
#       "id": 664963,
#       "length": null,
#       "match_id": 566065,
#       "position": 2,
#       "status": "not_started",
#       "video_url": null,
#       "winner": {
#         "id": null,
#         "type": null
#       },
#       "winner_type": null
#     }
#   ],
#   "videogame_version": null,
#   "tournament": {
#     "begin_at": "2020-08-02T03:00:00Z",
#     "end_at": null,
#     "id": 4447,
#     "league_id": 4436,
#     "live_supported": false,
#     "modified_at": "2020-07-15T13:31:38Z",
#     "name": "Group b",
#     "prizepool": null,
#     "serie_id": 2838,
#     "slug": "dota-2-moon-studio-asian-league-1-2020-group-b",
#     "winner_id": null,
#     "winner_type": "Team"
#   },
#   "scheduled_at": "2020-08-05T07:30:00Z",
#   "end_at": null
# },